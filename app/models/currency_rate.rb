class CurrencyRate < ApplicationRecord
  validates :value, presence: true, numericality: { greater_than: 0 }

  def self.current
    where('forced_until IS NULL or forced_until >= ?', Time.current)
      .order('CASE WHEN forced_until IS NULL THEN 1 ELSE 0 END ASC, ' \
             'created_at DESC')
      .first
  end
end
