require 'spec_helper'

describe TravelPayouts do
  def stub_data_api(fname, status: 200)
    stub_request(:get, @api.send("#{fname}_url"))
      .with(query: hash_including({}))
      .to_return(body: File.new("spec/responses/#{fname}.json"), status: status)
  end

  before(:all) do
    TravelPayouts.configure do |config|
      config.token = '<some token>'
      config.currency = 'rub'
    end

    @api = TravelPayouts.api
  end

  it 'returns calendar of prices' do
    stub_data_api(:calendar_of_prices)

    @api.calendar_of_prices(origin: :MOW, destination: :BKK, depart_date: '2015-05-16', one_way: true)
  end

  it 'raises an error for 500 response' do
    stub_data_api(:calendar_of_prices, status: 500)

    expect do
      @api.calendar_of_prices(origin: :MOW, destination: :BKK, depart_date: '2015-05-16', one_way: true)
    end.to raise_error(TravelPayouts::Error)
  end
end
