class Admin::CurrencyRate < ::CurrencyRate
  # A form model for admin currency rate editing
  class << self
    delegate :model_name, to: :superclass
  end

  validates :forced_until, presence: true
end
