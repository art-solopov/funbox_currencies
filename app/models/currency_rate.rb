class CurrencyRate < ApplicationRecord
  validates :value, presence: true, numericality: { greater_than: 0 }
  validate :forced_until_should_be_future

  after_commit :create_notification

  scope :forced, -> { where.not(forced_until: nil) }

  QUEUE = 'funbox_currency_rate'.freeze

  def self.current
    where('forced_until IS NULL or forced_until >= ?', Time.current)
      .order('CASE WHEN forced_until IS NULL THEN 1 ELSE 0 END ASC, ' \
             'created_at DESC')
      .first
  end

  def self.fetch_data!
    response = Faraday.get(Rails.application.config.currency_rates['url'])
    data = JSON.parse(response.body)
    create!(value: data['rates']['RUB'])
  end

  def self.notify_current
    ExternalService::Publish.publish(
      QUEUE,
      :current,
      currentValue: current&.value
    )
  end

  private

  def forced_until_should_be_future
    return if forced_until.nil? || forced_until.future?
    errors.add(:forced_until, :should_be_future)
  end

  def create_notification
    CurrencyRatePublishingWorker.perform_async
    if forced_until.present? && forced_until.future?
      CurrencyRatePublishingWorker.perform_at(forced_until)
    end
  end
end
