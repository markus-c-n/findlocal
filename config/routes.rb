# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  root to: 'items#index'

  resources :items do
    collection do
      post :import_csv
    end
  end
  resources :stores do
    resources :items, only: [:new, :create]
  end
  resources :categories do
    get 'sub_categories', on: :member
  end
end
