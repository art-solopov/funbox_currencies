require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  describe 'validations' do
    subject { FactoryGirl.create(:currency_rate) }
    it { expect(subject).to be_valid }

    describe 'value presence' do
      before { subject.value = nil }
      it { expect(subject).to be_invalid }
    end

    describe 'value numericality' do
      before { subject.value = -10 }
      it { expect(subject).to be_invalid }
    end
  end
end
