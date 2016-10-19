module TravelPayouts
  class Api
    module Request
      require 'json'
      require 'hashie/mash'

      def request(url, params, skip_parse: false)
        params[:currency] ||= config.currency
        params[:locale]   ||= config.locale

        params.delete_if{ |_, v| v == nil }

        data = RestClient.get url, request_headers.merge(params: params)
        skip_parse ? data : respond(data)
      rescue RestClient::Exception => e
        err = Error.new(e.response, e.http_code)
        err.message = e.message
        raise err
      end

      def signed_flight_request(method, url, params)
        params[:host]     = config.host
        params[:currency] ||= config.currency
        params[:locale]   ||= config.locale if params.has_key?(:locale)

        params.delete_if{ |_, v| v == nil }

        params[:signature] = signature(params)
        params[:marker]   = config.marker.to_s

        run_request(url, params, request_headers(true), method)
      end

      def signed_hotel_request(method, url, params)
        params[:currency] ||= config.currency
        params[:lang]     ||= config.locale if params.has_key?(:lang)

        params.delete_if{ |_, v| v == nil }

        params[:signature] = signature(params, config.marker)
        params[:marker]    = config.marker.to_s

        run_request(url, params, request_headers(true), method)
      end

      def sort_params(params)
        return params unless params.is_a?(Hash) || params.is_a?(Array)
        return Hash[params.sort.map{ |k,v| [k, sort_params(v)] }] if params.is_a?(Hash)
        params.map{|p| sort_params(p)}
      end

      def param_values(params)
        return params unless params.is_a?(Hash) || params.is_a?(Array)
        return params.values.map{|v| param_values(v)}.flatten if params.is_a?(Hash)
        params.map{|p| param_values(p)}.flatten
      end

      def signature(params, marker=nil)
        sign = marker ? [config.token, marker] : [config.token]
        values = sign + param_values(sort_params(params))
        Digest::MD5.hexdigest values.join(':')
      end

      def request_headers(include_content_type = false)
        {
          x_access_token: config.token,
          accept_encoding: 'gzip, deflate',
          accept: :json
        }.tap do |headers|
          headers[:content_type] = 'application/json' if include_content_type
        end
      end

      def respond(resp)
        begin
          hash = JSON.parse(resp)
        rescue => _
          return resp
        end

        convert_to_mash hash
      end

      def run_request(url, params, headers, method)
        return respond RestClient.post url, params.to_json, headers if method == :post
        respond RestClient.get url, headers.merge(params: params)
      rescue RestClient::Exception => e
        err = Error.new(e.response, e.http_code)
        err.message = e.message
        raise err
      end

      def convert_to_mash(hash)
        return Hashie::Mash.new hash if hash.is_a? Hash
        return hash unless hash.is_a? Array
        hash.each{ |_,v| convert_to_mash v }
      end
    end
  end
end
