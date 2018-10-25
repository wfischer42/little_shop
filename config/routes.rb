Rails.application.routes.draw do

  resources :items, only: [:index]
  resources :merchants, only: [:index]

  # scope :profile, only: [:edit] do
  #   resources :user, only: [:edit]
  # end

  root 'welcome#index'
  get '/profile', to: "users#profile"
  get '/profile/edit/', to: "users/profile#edit"
  get '/cart', to: 'cart_items#index'
  get '/login', to: "sessions#new"
  get '/register', to: "users#new"
  post '/register', to: 'users#create'

end
