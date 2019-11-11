class V1::CurrenciesController < ApplicationController

  def all
    render json: SUPPORTED_CURRENCIES
  end

  def convert
    begin
      service = ConvertRatesService.new(params[:amount], params[:from], params[:to])
      render json: { result: service.result }, status: :ok
    rescue ConvertRatesService::Error::UnknownCurrency => e
      render json: { errors: e.message }, status: :bad_request
    end
  end
end
