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

  # @return [String]
  def cache
    @cache ||= begin
      proc do |v|
        key = 'money:currencylayer_bank:cache'

        if v
          redis_client.set(key, v)
        else
          redis_client.get(key)
        end
      end
    end
  end

  def currencies
    @currencies ||= RatesHistory::SUPPORTED_CURRENCIES
  end

  # @return [Redis]
  def redis_client
    @redis_client = Redis.current
  end

  # @return [String]
  #   As we're interested only in specific currencies,
  #     we could filter them using API.
  def source_url
    raise NoAccessKey if access_key.blank?

    url = CL_URL
    url = CL_SECURE_URL if secure_connection

    "#{url}?source=#{source}&access_key=#{access_key}&currencies=#{currencies.join(',')}"
  end

  # @return [Integer] Cache time to live.
  def ttl_in_seconds
    @ttl_in_seconds ||= 86400
  end
end