Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#show'
  get '/:locale',
      to: 'home#show',
      constraints: { locale: /#{I18n.available_locales.join('|')}/ }

  namespace :admin do
    controller :currency_rates do
      get '/', action: :new
      post '/', action: :create
    end
  end

  if Rails.env.development?
    require 'sidekiq/web'
    require 'sidekiq/cron/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
