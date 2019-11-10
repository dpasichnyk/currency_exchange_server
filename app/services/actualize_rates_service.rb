require 'currency_layer'

class ActualizeRatesService

  # @return [void]
  def perform
    CurrencyLayer.instance.update_rates(true)
    store_histories
  end

  private

  # @return [String]
  def main_currency
    @main_currency ||= 'EUR'
  end

  # @raise [ActiveRecord::Money::Currency::UnknownCurrency]
  # @raise [ActiveRecord::RecordInvalid]
  # @return [void]
  def store_histories
    currencies = RatesHistory::SUPPORTED_CURRENCIES - [main_currency]

    RatesHistory.transaction do
      currencies.each do |currency|
        combination = [main_currency, currency]
        value = Money.default_bank.get_rate(*combination)

        RatesHistory.find_or_initialize_by(date: Date.today, from_currency: main_currency, to_currency: currency).tap do |history|
          history.rate = value
          history.save!
        end
      end
    end
  end
end