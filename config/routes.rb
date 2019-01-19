Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'login', to: 'sessions#update'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :update]
  resources :events do
    member do
      get :followers
    end
  end  
  resources :messages
  
  resources :comments, only: [:create, :destroy]
  resources :participates, only: [:create, :destroy]
end
