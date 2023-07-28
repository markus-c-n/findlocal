# config/routes.rb
Rails.application.routes.draw do
  root to: 'items#index'
  resources :items
  resources :stores, only: [:show, :destroy] do
    resources :items, only: [:new, :create]
  end
end
