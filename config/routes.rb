Rails.application.routes.draw do

  resources :items, only: [:index]
  resources :merchants, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create]
  end

  root 'welcome#index'
  get '/profile', to: "users#profile"
  get '/cart', to: 'cart_items#index'
  get '/login', to: "sessions#new"
  get '/register', to: "users#new"
  post '/register', to: 'users#create'

end
