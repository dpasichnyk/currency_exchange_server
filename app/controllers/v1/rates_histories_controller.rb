class V1::RatesHistoriesController < ApplicationController
  def index
    rates_histories = RatesHistory.where('date <= ?', Date.today).order(:date)

    render json: RatesHistoryBlueprint.render(rates_histories)
  end
end
