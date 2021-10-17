Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: :create
      resources :billing_statistics, only: :create
      get 'billing_statistic/:user_id', to: 'billing_statistics#show'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
