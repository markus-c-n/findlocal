# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  root to: 'items#index'

  resources :items
  resources :stores do
    resources :items, only: [:new, :create]
  end
end
