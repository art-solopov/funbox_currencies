class Admin::CurrencyRatesController < ApplicationController
  layout 'admin'
  before_action :load_previous_values

  def new
    @currency_rate = Admin::CurrencyRate.new
  end

  def create
    @currency_rate = Admin::CurrencyRate.new(currency_rate_params)
    if @currency_rate.save
      redirect_to admin_path
    else
      render :new
    end
  end

  private

  def currency_rate_params
    params.require(:currency_rate)
          .permit(:value, :forced_until)
          .tap { |e| e[:value] = e[:value].try(:gsub, ',', '.') }
  end

  def load_previous_values
    @previous_values = ::CurrencyRate.forced.order(forced_until: :desc)
  end
end
