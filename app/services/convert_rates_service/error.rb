class ConvertRatesService
  class Error < StandardError
    class UnknownCurrency < Error
    end
  end
end
