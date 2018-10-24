Rails.application.routes.draw do

  resources :items, only: [:index]
  resources :merchants, only: [:index]

  root 'welcome#index'
  get '/cart', to: 'cart_items#index'
  get '/login', to: "sessions#new"
  get '/register', to: "users#new"


end
