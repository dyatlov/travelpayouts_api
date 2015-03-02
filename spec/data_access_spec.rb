require 'spec_helper'

describe TravelPayouts do
  def stub_data_api(fname)
    stub_request(:get, @api.send("#{fname}_url"))
      .with(query: hash_including({}))
      .to_return(body: File.new("spec/responses/#{fname}.json"))
  end

  before(:all) do
    TravelPayouts.configure do |config|
      config.token = '<some token>'
      config.currency = 'rub'
    end

    @api = TravelPayouts.api
  end

  it 'returns cheap prices' do
    stub_data_api(:cheap_prices)

    @api.cheap_prices(origin: 'ODS', destination: 'MOW', depart_date: '2015-04-01')
  end

  it 'returns direct prices' do
    stub_data_api(:direct_prices)

    @api.direct_prices(origin: 'ODS', destination: 'MOW', depart_date: '2015-04-01')
  end

  it 'returns calendar prices' do
    stub_data_api(:calendar_prices)

    @api.calendar_prices(origin: 'ODS', destination: 'MOW', depart_date: '2015-04-01', calendar_type: :departure_date)
  end

  it 'returns airline directions' do
    stub_data_api(:airline_directions)

    @api.airline_directions(airline_code: 'SU')
  end

  it 'returns countries data' do
    stub_data_api(:countries_data)

    @api.countries_data
  end

  it 'returns cities data' do
    stub_data_api(:cities_data)

    @api.cities_data
  end

  it 'returns airports data' do
    stub_data_api(:airports_data)

    @api.airports_data
  end

  it 'returns airlines data' do
    stub_data_api(:airlines_data)

    @api.airlines_data
  end

  it 'returns airline alliances data' do
    stub_data_api(:airline_alliances_data)

    @api.airline_alliances_data
  end

  it 'returns planes data' do
    stub_data_api(:planes_data)

    @api.planes_data
  end

  it 'returns routes data' do
    stub_data_api(:routes_data)

    @api.routes_data
  end

  it 'returns user location' do
    stub_data_api(:where_am_i)

    @api.where_am_i locale: :ru, ip: '62.105.128.2'
  end
end
