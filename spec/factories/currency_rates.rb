FactoryGirl.define do
  factory :currency_rate do
    value { 50 + rand(1.2...9.0) }
  end
end
