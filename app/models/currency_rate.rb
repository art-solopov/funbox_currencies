class CurrencyRate < ApplicationRecord
  validates :value, presence: true, numericality: { greater_than: 0 }
  validate :forced_until_should_be_future

  def self.current
    where('forced_until IS NULL or forced_until >= ?', Time.current)
      .order('CASE WHEN forced_until IS NULL THEN 1 ELSE 0 END ASC, ' \
             'created_at DESC')
      .first
  end

  private

  def forced_until_should_be_future
    return if forced_until.nil? || forced_until.future?
    errors.add(:forced_until, :should_be_future)
  end
end
