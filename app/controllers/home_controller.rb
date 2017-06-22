class HomeController < ApplicationController
  def show
    @value = CurrencyRate.current.try(:value)
  end
end
