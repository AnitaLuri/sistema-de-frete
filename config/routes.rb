Rails.application.routes.draw do
  devise_for :users
  root  'home#index'

  resources :transport_modes, only: [:show, :new, :create, :edit, :update] do
    post 'active', on: :member
    post 'inactive', on: :member
  end
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end
  resources :weight_prices, only: [:index, :new, :create, :edit, :update]
  resources :distance_prices, only: [:index, :new, :create, :edit, :update]
  resources :deadlines, only: [:index, :new, :create, :edit, :update]
  resources :service_orders, only: [:index,  :show, :new, :create, :edit, :update] do
    resources :started_orders, only: [:index, :show, :new, :create] do
      get 'included' 
      post 'concluded'
    end
    get 'search', on: :collection
  end
end
