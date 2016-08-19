Rails.application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:new, :create, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'

  

  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'end_impersonate'
      end
      member do
        get 'impersonate' 
      end
    end
  end 

end
