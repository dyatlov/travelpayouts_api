module TravelPayouts
  class Api
    module Hotel
      def hotel_lookup_url
        'http://engine.hotellook.com/api/v2/lookup.json'
      end

      def hotel_prices_url
        'http://yasen.hotellook.com/api/v2/cache.json'
      end

      def hotel_countries_url
        'http://engine.hotellook.com/api/v2/static/countries.json'
      end

      def hotel_locations_url
        'http://engine.hotellook.com/api/v2/static/locations.json'
      end

      def hotel_amenities_url
        'http://engine.hotellook.com/api/v2/static/amenities.json'
      end

      def hotels_list_url
        'http://engine.hotellook.com/api/v2/static/hotels.json'
      end

      def hotel_room_types_url
        'http://engine.hotellook.com/api/v2/static/roomTypes.json'
      end

      def hotel_types_url
        'http://engine.hotellook.com/api/v2/static/hotelTypes.json'
      end

      def hotel_search_start_url
        'http://engine.hotellook.com/api/v2/search/start.json'
      end

      def hotel_search_result_url
        'http://engine.hotellook.com/api/v2/search/getResult.json'
      end

      def hotel_lookup(query:, lang: nil, look_for: nil, limit: 10, convert_case: true)
        signed_hotel_request :get, hotel_lookup_url, {
          query: query,
          lang: lang,
          lookFor: look_for,
          limit: limit,
          convertCase: convert_case.to_s
        }
      end

      def hotel_prices(user_ip:, check_in:,check_out:,location:nil,location_id:nil,hotel_id:nil,hotel:nil,limit:10)
        signed_hotel_request :get, hotel_prices_url, {
          customerIp: user_ip,
          checkIn: check_in,
          checkOut: check_out,
          location: location,
          locationId: location_id,
          hotelId: hotel_id,
          hotel: hotel,
          limit: limit
        }
      end

      def hotel_countries
        signed_hotel_request :get, hotel_countries_url, {}
      end

      def hotel_locations
        signed_hotel_request :get, hotel_locations_url, {}
      end

      def hotel_amenities
        signed_hotel_request :get, hotel_amenities_url, {}
      end

      def hotels_list(location_id:)
        signed_hotel_request :get, hotels_list_url, {locationId: location_id}
      end

      def hotel_room_types
        signed_hotel_request :get, hotel_room_types_url, {}
      end

      def hotel_types
        signed_hotel_request :get, hotel_types_url, {}
      end

      def hotel_search_start(city_id:nil,hotel_id:nil,iata:nil,check_in:,check_out:,adults_count:,user_ip:,
        children_count:0,child_age1:0,child_age2:0,child_age3:0,lang:nil,currency:nil,wait_for_result:0,timeout:20)
        signed_hotel_request :get, hotel_search_start_url, {
          cityId: city_id,
          hotelId: hotel_id,
          iata: iata,
          checkIn: check_in,
          checkOut: check_out,
          adultsCount: adults_count,
          customerIp: user_ip,
          childrenCount: children_count,
          childAge1: child_age1,
          childAge2: child_age2,
          childAge3: child_age3,
          lang: lang,
          currency: currency,
          waitForResult: wait_for_result,
          timeout: timeout
        }
      end

      def hotel_search_result(search_id:,limit: 0,offset: 0,sort_by: :popularity, sort_asc: 1, rooms_count: 0)
        signed_hotel_request :get, hotel_search_result_url, {
          searchId: search_id,
          limit: limit,
          offset: offset,
          sortBy: sort_by,
          sortAsc: sort_asc,
          roomsCount: rooms_count
        }
      end
    end
  end
end
