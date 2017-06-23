class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    locale = params[:locale] || session[:locale] ||
             extract_locale_from_header ||
             I18n.default_locale
    I18n.locale = locale
    session[:locale] = I18n.locale
  end

  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
