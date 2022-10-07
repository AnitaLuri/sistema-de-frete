Rails.application.routes.draw do
  devise_for :users
  root  'home#index'

  resources :transport_modes, only: [:new, :create, :show, :edit, :update] do
    post 'active', on: :member
    post 'inactive', on: :member
  end
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end
  resources :weight_prices, only: [:new, :create, :index, :edit, :update]
end
