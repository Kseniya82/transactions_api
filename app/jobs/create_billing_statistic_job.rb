class CreateBillingStatisticJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CreateBillingStatisticService.new(*args).call
  end
end
