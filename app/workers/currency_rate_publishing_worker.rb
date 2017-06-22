class CurrencyRatePublishingWorker
  include Sidekiq::Worker

  def perform
    CurrencyRate.notify_current
  end
end
