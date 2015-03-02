module TravelPayouts
  class Api
    module Map
      def map_of_supported_directions_url
        'http://map.aviasales.ru/supported_directions.json'
      end

      def map_of_prices_url
        'http://map.aviasales.ru/prices.json'
      end

      def map_of_supported_directions(origin_iata:, one_way: true, locale: nil)
        request map_of_supported_directions_url, {
          origin_iata: origin_iata,
          one_way: one_way,
          locale: locale
        }
      end

      def map_of_prices(origin_iata:, period: :month, one_way: true, direct: false,
          price: nil, no_visa: true, schengen: nil, need_visa: true, locale: nil,
          min_trip_duration_in_days: nil, max_trip_duration_in_days: nil)
        request map_of_prices_url, {
          origin_iata: origin_iata,
          period: period,
          one_way: one_way,
          direct: direct,
          price: price,
          no_visa: no_visa,
          schengen: schengen,
          need_visa: need_visa,
          locale: locale,
          min_trip_duration_in_days: min_trip_duration_in_days,
          max_trip_duration_in_days: max_trip_duration_in_days
        }
      end
    end
  end
end
