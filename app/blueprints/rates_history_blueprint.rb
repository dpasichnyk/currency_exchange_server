class RatesHistoryBlueprint < Blueprinter::Base
  fields :date, :from_currency, :to_currency, :rate
end