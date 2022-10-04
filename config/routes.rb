Rails.application.routes.draw do
  devise_for :users
  root  'home#index'

  resources :transport_modes, only: [:new, :create, :show, :edit, :update] do
    post 'active', on: :member
    post 'inactive', on: :member
  end
end
