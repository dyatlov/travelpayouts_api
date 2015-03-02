module TravelPayouts
  class Api
    module Flight
      def flight_search_url
        'http://api.travelpayouts.com/v1/flight_search'
      end

      def flight_search_results_url
        'http://api.travelpayouts.com/v1/flight_search_results'
      end

      def flight_search_link_url(search_id:, terms_url:)
        "http://api.travelpayouts.com/v1/flight_searches/#{search_id}/clicks/#{terms_url}.json"
      end

      def autocomplete_places_url
        'http://places.aviasales.ru'
      end

      def flight_search_link(search_id:, terms_url:)
        request flight_search_link_url(search_id: search_id, terms_url: terms_url), {}
      end

      def flight_search(user_ip:,locale: nil, trip_class: 'Y', passengers: {}, segments: {}, know_english: true)
        signed_flight_request :post, flight_search_url, {
          user_ip: user_ip,
          locale: locale,
          trip_class: trip_class,
          passengers: passengers,
          segments: segments,
          know_english: know_english.to_s
        }
      end

      def flight_search_results(search_id:)
        request flight_search_results_url, { uuid: search_id }
      end

      def autocomplete_places(term:, locale: nil)
        request autocomplete_places_url, {
          term: term,
          locale: locale
        }
      end
    end
  end
end
