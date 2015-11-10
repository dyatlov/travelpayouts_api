require 'spec_helper'

describe TravelPayouts::Api do
  let(:params) {
    {
      :signature => "2e8f5657aeaa13d0c5ae4426d9fdbd76",
      :marker => "88888",
      :host => "beta.aviasales.ru",
      :user_ip => "127.0.0.1",
      :locale => "ru",
      :trip_class => "Y",
      :passengers => {
        :adults => 1,
        :children => 0,
        :infants => 0
      },
      :segments => [{
          :origin => "NYC",
          :destination => "LAX",
          :date => "2015-11-25"
        }, {
          :origin => "LAX",
          :destination => "NYC",
          :date => "2015-12-18"
        }]
    }
  }
  before(:all) do
    TravelPayouts.configure do |config|
      config.token = 'some'
      config.currency = 'usd'
      config.marker = '88888'
      config.host = 'beta.aviasales.ru'
      config.locale = 'en'
    end

    @api = TravelPayouts.api
  end

  it 'sorts params properly' do
    expect(@api.sort_params(params).keys).to eq(params.keys.sort)
  end

  it 'provides correct signature' do
    sign = params.delete(:signature)
    expect(@api.signature(params)).to eq(sign)
  end

  it 'provides headers for request without content_type by default' do
    expect(@api.request_headers).not_to have_key(:content_type)
  end

  it 'provides headers for request with content_type' do
    expect(@api.request_headers(true)).to have_key(:content_type)
  end
end
