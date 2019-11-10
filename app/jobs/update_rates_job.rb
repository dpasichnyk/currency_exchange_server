class UpdateRatesJob < ApplicationJob
  queue_as :rates_sync

  def perform(*)
    ActualizeRatesService.new.perform
  end
end
