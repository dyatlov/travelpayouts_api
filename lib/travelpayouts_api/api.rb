module TravelPayouts
  class Api
    include TravelPayouts::Api::Request
    include TravelPayouts::Api::DataAccess
    include TravelPayouts::Api::Map
    include TravelPayouts::Api::Calendar
    include TravelPayouts::Api::Flight
    include TravelPayouts::Api::Hotel

    attr_reader :config

    def initialize(config = {})
      @config = TravelPayouts.config
      for k,v in config
        @config[k.to_sym] = v
      end
    end
  end
end
