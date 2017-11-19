Rails.application.routes.draw do
  resources :assignments
  root to: 'home#show'

  devise_for :users

  resources :users
  resources :courses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
