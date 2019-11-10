require 'rails_helper'

RSpec.describe ActualizeRatesService do
  let!(:history1) { create :rates_history, date: Date.today, from_currency: 'EUR', to_currency: 'USD', rate: 1 }
  let!(:history2) { create :rates_history, date: Date.today, from_currency: 'EUR', to_currency: 'CHF', rate: 2 }
  let(:correct_response) { "{\"quotes\":{\"USDCHF\":0.666666,\"USDEUR\":0.777777,\"USDUSD\":1}}" }

  let(:instance) { described_class.new }

  describe '#perform' do
    before do
      stub_request(:get, /\Ahttp:\/\/apilayer\.net\/api\/live/).
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
        .to_return(status: 200, body: correct_response, headers: {})
    end

    subject { instance.perform }

    context 'when error' do
      let(:wrong_currency_name) { 'HEYHOPLALALEY' }

      it 'rolls back the transaction' do
        expect(instance).to receive(:main_currency)
          .at_least(:once)
          .and_return(wrong_currency_name)

        expect { subject }.to raise_error(Money::Currency::UnknownCurrency, /Unknown currency '#{wrong_currency_name.downcase}'/)
        expect(history1.reload.rate).to eq(1)
      end
    end

    context 'when success' do
      it 'generally works' do
        expect { subject }.to change { history1.reload.rate }.from(1).to(1.285716)
          .and change { history2.reload.rate }.from(2).to(0.857143)
      end
    end
  end
end