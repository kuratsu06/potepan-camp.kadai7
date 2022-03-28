Rails.application.routes.draw do
  root 'home#index'
  get 'search' => 'rooms#search'
  get 'seek' => 'rooms#seek'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :rooms
  resources :reservations
end