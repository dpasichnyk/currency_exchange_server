class ActualizeRatesService

  # @return [void]
  def perform
    CurrencyLayer.instance.update_rates(true)
  end
end