require 'spec_helper'

describe TravelPayouts do
  def stub_data_api(method, fname)
    stub_request(method, @api.send("#{fname}_url"))
      .with(query: hash_including({}))
      .to_return(body: File.new("spec/responses/#{fname}.json"))
  end

  before(:all) do
    TravelPayouts.configure do |config|
      config.token = '<some token>'
      config.currency = 'rub'
      config.marker = '75747'
      config.host = 'localhost'
      config.locale = 'en'
    end

    @api = TravelPayouts.api
  end

  it 'initiates a hotel search' do
    stub_data_api(:get, :hotel_lookup)

    @api.hotel_lookup(query: 'moscow', look_for: :hotel)
  end

  it 'returns hotel prices' do
    stub_data_api(:get, :hotel_prices)

    @api.hotel_prices(user_ip: '127.0.0.1', location: 'Moscow', check_in: '2015-06-10', check_out: '2015-06-12', limit: 10)
  end

  it 'returns hotel types' do
    stub_data_api(:get, :hotel_types)

    @api.hotel_types
  end

  it 'returns hotels list' do
    stub_data_api(:get, :hotels_list)

    @api.hotels_list(location_id: 895)
  end

  it 'starts hotel search' do
    stub_data_api(:get, :hotel_search_start)

    @api.hotel_search_start(iata: :mow, check_in: '2015-06-10', check_out: '2015-06-13', adults_count: 2, user_ip: '127.0.0.1', children_count: 1, lang: :en, currency: :USD, timeout: 20, wait_for_result: 0)
  end

  it 'returns search results' do
    stub_data_api(:get, :hotel_search_result)

    @api.hotel_search_result(search_id: 4540808, limit: 10)
  end
end
