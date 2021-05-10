Rails.application.routes.draw do
  get 'customers/index'
  get 'cutomers/index'
  root "articles#index"
  resources :articles do
    resources :comments
  end
  resources :customers
end
