module TravelPayouts
  class Api
    module DataAccess
      def cheap_prices_url
        'http://api.travelpayouts.com/v1/prices/cheap'
      end

      def direct_prices_url
        'http://api.travelpayouts.com/v1/prices/direct'
      end

      def calendar_prices_url
        'http://api.travelpayouts.com/v1/prices/calendar'
      end

      def airline_directions_url
        'http://api.travelpayouts.com/v1/airline-directions'
      end

      def countries_data_url
        'http://api.travelpayouts.com/data/countries.json'
      end

      def cities_data_url
        'http://api.travelpayouts.com/data/cities.json'
      end

      def airports_data_url
        'http://api.travelpayouts.com/data/airports.json'
      end

      def airlines_data_url
        'http://api.travelpayouts.com/data/airlines.json'
      end

      def airline_alliances_data_url
        'http://api.travelpayouts.com/data/airlines_alliances.json'
      end

      def planes_data_url
        'http://api.travelpayouts.com/data/planes.json'
      end

      def routes_data_url
        'http://api.travelpayouts.com/data/routes.json'
      end

      def where_am_i_url
        'http://www.travelpayouts.com/whereami'
      end

      def cheap_prices(origin:, destination:, depart_date: nil, return_date: nil)
        request cheap_prices_url, {
          origin: origin,
          destination: destination,
          depart_date: depart_date,
          return_date: return_date
        }
      end

      def direct_prices(origin:, destination:, depart_date: nil, return_date: nil)
        request direct_prices_url, {
          origin: origin,
          destination: destination,
          depart_date: depart_date,
          return_date: return_date
        }
      end

      def calendar_prices(origin:, destination:, calendar_type:, depart_date: nil, trip_duration: nil, return_date: nil)
        request calendar_prices_url, {
          origin: origin,
          destination: destination,
          depart_date: depart_date,
          return_date: return_date,
          calendar_type: calendar_type,
          trip_duration: trip_duration
        }
      end

      def airline_directions(airline_code:, limit: 10)
        request airline_directions_url, {
          airline_code: airline_code,
          limit: limit
        }
      end

      def countries_data
        request countries_data_url, {}
      end

      def cities_data
        request cities_data_url, {}
      end

      def airports_data
        request airports_data_url, {}
      end

      def airlines_data
        request airlines_data_url, {}
      end

      def airline_alliances_data
        request airline_alliances_data_url, {}
      end

      def planes_data
        request planes_data_url, {}
      end

      def routes_data
        request routes_data_url, {}
      end

      def where_am_i(ip:, locale: nil)
        data = request where_am_i_url, {
          callback: 'a',
          ip: ip,
          locale: locale
        }

        js = data.slice(2..-2)
        respond(js)
      end
    end
  end
end
