require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  before do
    FactoryGirl.create(:currency_rate)
    2.times { FactoryGirl.create(:currency_rate, forced_until: 1.day.from_now) }
    FactoryGirl.create(:currency_rate)

    visit admin_path
  end

  it 'renders the admin fine' do
    expect(page).to have_css('.container')
  end

  it 'renders the previous list' do
    expect(page).to have_css('#previous_values .list-group-item', count: 2)
  end

  context 'creates the new currency rate' do
    before do
      # Using the value that isn't available to a factory
      fill_in 'currency_rate_value', with: '90.00'
      fill_in 'currency_rate_forced_until',
              with: 3.days.from_now.strftime('%d.%m.%Y %H:%M')
      find('#new_currency_rate .btn').click
    end

    let(:last) { CurrencyRate.last }
    subject do
      find("#previous_values .list-group-item#prev_val_#{last.id} .val")
    end

    it do
      expect(page).to have_css('#previous_values .list-group-item', count: 3)
    end

    it do
      expect(subject.text).to eq '90.000'
    end
  end

  context 'form validation' do
    before do
      find('#new_currency_rate .btn').click
    end

    it { expect(page).to have_css('form .text-danger', count: 2) }
  end
end
