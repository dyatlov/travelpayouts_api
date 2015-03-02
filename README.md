# TravelPayouts API

[![Gem Version](http://img.shields.io/gem/v/travelpayouts_api.svg)][gem]

[gem]: https://rubygems.org/gems/travelpayouts_api

** This gem supports `ruby 2.2` and above. It won't work on earlier ruby versions due to extensive use of positional parameters.

## Overview

This gem supports

 * Data Access API ( http://support.travelpayouts.com/hc/ru/articles/203956163 )
 * Map API ( http://support.travelpayouts.com/hc/ru/articles/203755406 )
 * Calendar API ( http://support.travelpayouts.com/hc/ru/articles/203972143 )
 * Flights API ( http://support.travelpayouts.com/hc/ru/articles/203956173 )
 * Hotels API ( http://support.travelpayouts.com/hc/ru/articles/203956133 )

 ## How to use

 Include it in your `Gemfile`:

 ```ruby
 gem 'travelpayouts_api'
 ```

 Create an initializer in config/initializers:

 ```ruby
 # config/initializers/travelpayouts_api.rb
 TravelPayouts.configure do |config|
   config.token = '<token>'
   config.marker = '<marker>'
   config.host = 'localhost'
   config.currency = 'rub'
   config.locale = 'en'
 end
 ```

where

 * `token` - your api token
 * `marker` - your client id in travelpayouts system
 * `currency` - currency 3-digit code
 * `host` - should be set to your site host
 * `locale` - language of results


And now in your controller you can do something like this:

```ruby
@api = TravelPayouts.api
prices = @api.cheap_prices(origin: 'ODS', destination: 'MOW', depart_date: '2015-04-01')
```

All API calls will return hash objects or raise exceptions on failure.

## Data Access API

```ruby
cheap_prices(origin:, destination:, depart_date: nil, return_date: nil)
```

```ruby
direct_prices(origin:, destination:, depart_date: nil, return_date: nil)
```

```ruby
calendar_prices(origin:, destination:, calendar_type:, depart_date: nil, trip_duration: nil, return_date: nil)
```

```ruby
airline_directions(airline_code:, limit: 10)
```

```ruby
countries_data()
```

```ruby
cities_data()
```

```ruby
airports_data()
```

```ruby
airlines_data()
```

```ruby
airline_alliances_data()
```

```ruby
planes_data()
```

```ruby
routes_data()
```

```ruby
where_am_i(ip: nil, locale: nil)
```

## Map API

```ruby
map_of_supported_directions(origin_iata:, one_way: true, locale: nil)
```

```ruby
map_of_prices(origin_iata:, period: :month, one_way: true, direct: false,
    price: nil, no_visa: true, schengen: nil, need_visa: true, locale: nil,
    min_trip_duration_in_days: nil, max_trip_duration_in_days: nil)
```

## Flights API

```ruby
flight_search(user_ip:,locale: nil, trip_class: 'Y', passengers: {}, segments: {}, know_english: true)
```

```ruby
flight_search_link(search_id:, terms_url:)
```

```ruby
flight_search_results(search_id:)
```

```ruby
autocomplete_places(term:, locale: nil)
```

## Hotels API

```ruby
hotel_lookup(query:, lang: nil, look_for: nil, limit: 10, convert_case: true)
```

```ruby
hotel_prices(user_ip:, check_in:,check_out:,location:nil,location_id:nil,hotel_id:nil,hotel:nil,limit:10)
```

```ruby
hotel_countries()
```

```ruby
hotel_locations()
```

```ruby
hotel_amenities()
```

```ruby
hotels_list(location_id:)
```

```ruby
hotel_room_types()
```

```ruby
hotel_types()
```

```ruby
hotel_search_start(city_id:nil,hotel_id:nil,iata:nil,check_in:,check_out:,adults_count:,user_ip:,
  children_count:0,child_age1:0,child_age2:0,child_age3:0,lang:nil,currency:nil,wait_for_result:0,timeout:20)
```

```ruby
hotel_search_result(search_id:,limit: 0,offset: 0,sort_by: :popularity, sort_asc: 1, rooms_count: 0)
```
