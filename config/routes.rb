Rails.application.routes.draw do
  resources :users do
    resources :wallets
    resources :recipients
    resources :payins
    resources :payouts
    post 'wallet/topup', to: 'wallets#wallet_topup'
  end
  post '/webhooks', to: 'webhook#webhook_events'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
