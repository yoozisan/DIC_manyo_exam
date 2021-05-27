Rails.application.routes.draw do
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
   resources :users
  end
  resources :tasks do
    collection do
      post :confirm
		end
	end
end
