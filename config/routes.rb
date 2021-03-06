Rails.application.routes.draw do
  resources :assignments
  root to: 'home#show'

  devise_for :users

  resources :users
  resources :courses do
    post :add_self, on: :member
    delete :drop_self, on: :member
    resources :assignments, shallow: true do
      resources :submissions, shallow: true
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
