Rails.application.routes.draw do

  root 'welcome#index'

  resources :items, only: [:index]

end
