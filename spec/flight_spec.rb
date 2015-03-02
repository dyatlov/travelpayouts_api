require 'spec_helper'

describe TravelPayouts do
  def stub_data_api(method, fname)
    stub_request(method, @api.send("#{fname}_url"))
      .with(query: hash_including({}))
      .to_return(body: File.new("spec/responses/#{fname}.json"))
  end

  before(:all) do
    TravelPayouts.configure do |config|
      config.token = '<token>'
      config.currency = 'rub'
      config.marker = '75747'
      config.host = 'localhost'
      config.locale = 'en'
    end

    @api = TravelPayouts.api
  end

  it 'initiates a search' do
    stub_data_api(:post, :flight_search)

    @api.flight_search(
    user_ip: '127.0.0.1',
    passengers: {adults: 1},
    segments: [
      {origin:"MOW",destination:"LED",date:"2015-05-25"},
      {origin: "LED",destination: "MOW",date: "2015-06-18"}])
  end

  it 'returns search results' do
    stub_data_api(:get, :flight_search_results)

    @api.flight_search_results(search_id: '<search id>')
  end

  it 'returns flight search link' do
    stub_request(:get, @api.flight_search_link_url(search_id: '1234', terms_url: '4321'))
      .with(query: hash_including({}))
      .to_return(body: File.new("spec/responses/flight_search_link.json"))

    @api.flight_search_link(search_id: '1234', terms_url: '4321')
  end

  it 'returns autocompletion' do
    stub_data_api(:get, :autocomplete_places)

    @api.autocomplete_places(term: 'moskow', locale: :en)
  end
end
