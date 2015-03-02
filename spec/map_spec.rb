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

  it 'returns map of supported directions' do
    stub_data_api(:map_of_supported_directions)

    @api.map_of_supported_directions(origin_iata: :LED, one_way: true, locale: :en)
  end

  it 'returns map of prices' do
    stub_data_api(:map_of_prices)

    @api.map_of_prices(origin_iata: :MOW, one_way: true, locale: :en)
  end
end
