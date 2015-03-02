module TravelPayouts
  class Api
    module Request
      require 'json'
      require 'hashie/mash'

      def request(url, params, skip_parse: false)
        token = config.token
        params[:currency] ||= config.currency
        params[:locale] ||= config.locale

        params.delete_if{ |_, v| v == nil }

        headers  = {
          x_access_token: token,
          accept_encoding: 'gzip, deflate',
          accept: :json
        }
        data = RestClient.get url, headers.merge(params: params)
        skip_parse ? data : respond(data)
      rescue RestClient::Exception => e
        err = Error.new(e.response, e.http_code)
        err.message = e.message
        raise err
      end

      def signed_flight_request(method, url, params)
        token = config.token
        params[:marker] = config.marker
        params[:host] = config.host
        params[:currency] ||= config.currency
        params[:locale] ||= config.locale if params.has_key?(:locale)

        params.delete_if{ |_, v| v == nil }

        values = [token] + param_values(sort_params(params))
        signature = Digest::MD5.hexdigest values.join(':')
        params[:signature] = signature

        headers  = {
          x_access_token: token,
          accept_encoding: 'gzip, deflate',
          accept: :json,
          content_type: 'application/json'
        }

        return respond RestClient.post url, params.to_json, headers if method == :post
        respond RestClient.get url, headers.merge(params: params)
      rescue RestClient::Exception => e
        err = Error.new(e.response, e.http_code)
        err.message = e.message
        raise err
      end

      def signed_hotel_request(method, url, params)
        params[:lang] ||= config.locale if params.has_key?(:lang)
        params[:currency] ||= config.currency

        params.delete_if{ |_, v| v == nil }

        values = [config.token, config.marker] + param_values(sort_params(params))
        signature = Digest::MD5.hexdigest values.join(':')
        params[:signature] = signature
        params[:marker] = config.marker

        headers  = {
          x_access_token: config.token,
          accept_encoding: 'gzip, deflate',
          accept: :json,
          content_type: 'application/json'
        }

        return respond RestClient.post url, params.to_json, headers if method == :post
        respond RestClient.get url, headers.merge(params: params)

      rescue RestClient::Exception => e
        err = Error.new(e.response, e.http_code)
        err.message = e.message
        raise err
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

      def respond(resp)
        begin
          hash = JSON.parse(resp)
        rescue => _
          return resp
        end

        convert_to_mash hash
      end

      def convert_to_mash(hash)
        return Hashie::Mash.new hash if hash.is_a? Hash
        return hash unless hash.is_a? Array
        hash.each{ |_,v| convert_to_mash v }
      end
    end
  end
end
