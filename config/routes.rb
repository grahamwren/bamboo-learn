Rails.application.routes.draw do
  resources :submissions
  resources :assignments
  root to: 'home#show'

  devise_for :users

  resources :users
  resources :courses do
    post :add_self, on: :member
    delete :drop_self, on: :member
    resources :assignments, shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
