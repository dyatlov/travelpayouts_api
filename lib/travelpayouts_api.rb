require 'rest_client'
require 'digest/md5'

require 'travelpayouts_api/request'
require 'travelpayouts_api/data_access'
require 'travelpayouts_api/map'
require 'travelpayouts_api/calendar'
require 'travelpayouts_api/flight'
require 'travelpayouts_api/hotel'
require 'travelpayouts_api/api'
require 'travelpayouts_api/error'

class Hash
  def to_query(namespace = nil)
    collect do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end
end

module TravelPayouts
  class << self

    def configure
      yield config
    end

    def config
      @config ||= OpenStruct.new {}
    end

    def api(config = {})
      TravelPayouts::Api.new(config)
    end
  end
end
