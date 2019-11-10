class UpdateRatesJob < ApplicationJob
  queue_as :currencies_sync

  def perform(*)
    ActualizeRatesService.new.perform
  end
end
