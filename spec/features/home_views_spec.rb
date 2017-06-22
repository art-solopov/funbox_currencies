require 'rails_helper'

RSpec.feature "HomeViews", type: :feature do
  def expect_exchange_rate(num)
    text = format('%.3f', num)
    page.find('#currency_exchange_app .exchange-rate', text: text)
  end

  before do
    3.times { FactoryGirl.create(:currency_rate) }
    visit root_path
  end

  it { expect(page).to have_css('#currency_exchange_app') }

  describe 'shows the data correctly' do
    let!(:expected) do
      FactoryGirl.create(
        :currency_rate,
        value: 75.1,
        forced_until: 1.day.from_now
      )
    end

    before { visit root_path }

    it { expect_exchange_rate(expected.value) }
  end

  describe 'updates value' do
    let(:val) { 70.8 }

    before do
      execute_script "App.value = #{val}"
    end

    it { expect_exchange_rate(val) }
  end
end
