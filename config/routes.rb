Rails.application.routes.draw do
  root "articles#index"
  resources :articles do
    resources :comments
  end
  resources :customers
  resources :payments
  resources :webhooks
end
