Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#show'

  namespace :admin do
    controller :currency_rates do
      get '/', action: :new
      post '/', action: :create
    end
  end
end
