require 'money'

Money.default_bank = CurrencyLayer.instance
Money.default_currency = Money::Currency.new('EUR')