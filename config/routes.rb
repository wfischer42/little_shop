Rails.application.routes.draw do

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]

  scope module: :admin, as: :admin do
    resources :orders, only: [:index, :show] do
      patch '/cancel', to: 'orders#cancel'
    end
    resources :items, only: [:edit, :update] do
      patch '/enable', to: 'items#enable'
      patch '/disable', to: 'items#disable'
    end
    resources :merchants, only: [:show, :edit, :update] do
      patch '/downgrade', to: 'merchants#downgrade'
      resources :orders, only: [:index]
      resources :items, only: [:index, :show, :update, :new, :create, :edit]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      patch '/upgrade', to: 'users#downgrade'
      resources :orders, only: [:index]
    end
  end

  scope module: :merchant, path: :dashboard, as: :merchant do
      patch '/fulfill', to: 'order_items#update' 
    resources :items, only: [:index, :show, :edit, :update, :new, :create] do
      patch '/enable', to: 'items#enable'
      patch '/disable', to: 'items#disable'
    end

    resources :orders, only: [:index, :show, :edit, :update] do
      patch '/cancel', to: 'orders#cancel'
    end
  end

  scope as: :profile, path: :profile do
    resources :orders, only: [:index, :create, :show] do
      patch '/cancel', to: 'orders#cancel'
    end
  end

  root  'welcome#index'
  get   '/register',           to: 'users#new'
  post  '/register',           to: 'users#create'
  get   '/profile/edit',       to: 'users#edit'
  patch '/profile',            to: 'users#update'
  get   '/profile',            to: 'users#profile'
  get   '/dashboard',          to: 'users#dashboard'
  get   '/login',              to: 'sessions#new'
  post  '/login',              to: 'sessions#create'
  delete '/logout',            to: 'sessions#destroy'
  get   '/cart',               to: 'cart_items#index'
  post  '/cart_items',         to: 'cart_items#create'
  delete '/cart_items',        to: 'cart_items#destroy'
  post 'cart_items/:id/add',   to: 'cart_items#add_item'
  post 'cart_items/:id/minus', to: 'cart_items#minus_item'
end
