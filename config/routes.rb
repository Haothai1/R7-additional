Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'customers#index' #root access goes first
  resources :customers
  resources :orders

  delete "/customers/customerAndOrders/:id", to: "customers#destroy_with_orders"
end
