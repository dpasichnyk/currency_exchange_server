require 'rails_helper'

RSpec.describe 'Currencies', type: :request do

  describe 'available currencies' do
    it 'generally works' do
      get '/v1/currencies/all'

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq ['CHF', 'EUR', 'USD']
    end
  end

  describe 'currency conversion' do
    let(:correct_response) { "{\"quotes\":{\"USDCHF\":0.666666,\"USDEUR\":0.777777,\"USDUSD\":1}}" }
    let(:url) { '/v1/currencies/convert' }
    let(:params) { {amount: 100, from: 'EUR', to: 'USD'} }

    before do
      stub_request(:get, /\Ahttp:\/\/apilayer\.net\/api\/live/).
          with(headers: {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'})
          .to_return(status: 200, body: correct_response, headers: {})

      get url, params: params
    end

    context 'when error' do
      let(:params) { {amount: 100, from: 'HEY', to: 'USD'} }

      it 'returns appropriate status' do
        expect(response.status).to eq 400
        expect(JSON.parse(response.body)['errors']).to eq 'Currency is not supported.'
      end
    end

    context 'when success' do
      it 'generally works' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['result']).to eq 128.57
      end
    end
  end
end