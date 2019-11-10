require 'money/bank/currencylayer_bank'
require 'singleton'

class CurrencyLayer < Money::Bank::CurrencylayerBank
  include Singleton

  def initialize
    super
  end

  private

  # @return [nil]
  # @return [String]
  def access_key
    @access_key ||= Rails.application.credentials.dig(:currency_layer_api_key)
  end

  # @return [Integer] Cache time to live.
  def ttl_in_seconds
    @ttl_in_seconds ||= 86400
  end
end