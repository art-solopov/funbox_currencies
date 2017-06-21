require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  before { visit admin_path }
  it 'renders the admin fine' do
    expect(page).to have_css('.container')
  end
end
