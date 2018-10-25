Rails.application.routes.draw do

  resources :items, only: [:index]
  resources :merchants, only: [:index]

  root  'welcome#index'
  get   '/profile',   to: 'users#profile'
  get   '/dashboard', to: 'users#dashboard'
  get   '/cart',      to: 'cart_items#index'
  get   '/login',     to: 'sessions#new'
  post  '/login',     to: 'sessions#create'
  get   '/register',  to: 'users#new'
  post  '/register',  to: 'users#create'

end
