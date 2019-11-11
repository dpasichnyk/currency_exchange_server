class ConvertRatesService
  attr_accessor \
    :amount,
    :from,
    :to

  def initialize(amount, from, to)
    @amount = amount
    @from = from
    @to = to
  end

  # @raise [Error::UnknownCurrency]
  # @return [Float]
  def result
    raise Error::UnknownCurrency, 'Currency is not supported.' unless valid_currencies?

    @result ||= Money.new(amount_cents, from).exchange_to(to).to_f
  end

  private

  attr_writer :result

  # @return [Integer]
  def amount_cents
    amount.to_s.gsub(/\D/, '').to_i * 100
  end

  # @return [Boolean]
  def valid_currencies?
    [from, to].all? { |value| value.in? SUPPORTED_CURRENCIES }
  end
end