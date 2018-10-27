Rails.application.routes.draw do

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  #
  # namespace :admin do
  #   resources :merchants, only: [:index, :show, :update, :create]
  # end

  scope module: :admin, as: :admin do
    resources :merchants, only: [:show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  root  'welcome#index'
  get   '/profile',   to: 'users#profile'
  get '/profile/edit/', to: "users#edit"
  patch '/profile/edit', to: "users#update"
  get   '/dashboard', to: 'users#dashboard'
  get   '/cart',      to: 'cart_items#index'
  get   '/login',     to: 'sessions#new'
  post  '/login',     to: 'sessions#create'
  get   '/register',  to: 'users#new'
  post  '/register',  to: 'users#create'
end
