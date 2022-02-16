Rails.application.routes.draw do
  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'

  resources :users

  get "/login", to: 'sessions#new'
  get "/logout", to: 'sessions#destroy'
  resource :sessions, only: :create

  resources :categories do
    resources :words, only: [:new, :create, :edit, :update, :destroy]
    namespace :admin do
      resources :categories
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
