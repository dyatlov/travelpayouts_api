module TravelPayouts
  class Api
    module Calendar
      def calendar_of_prices_url
        'http://min-prices.aviasales.ru/calendar_preload'
      end

      def calendar_of_prices(origin:, destination:, depart_date:, one_way:true)
        request calendar_of_prices_url, {
          origin: origin,
          destination: destination,
          depart_date: depart_date,
          one_way: one_way
        }
      end

    end
  end
end
