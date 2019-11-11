class RatesHistory < ApplicationRecord
  validates :from_currency, inclusion: { in: SUPPORTED_CURRENCIES }
  validates :to_currency, inclusion: { in: SUPPORTED_CURRENCIES }
  validates :rate, numericality: { greater_than: 0 }
end
