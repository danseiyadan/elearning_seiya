Rails.application.routes.draw do
  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'

  resources :users
    namespace :admin do
      resources :users, only: [:update]
    end

  get "/login", to: 'sessions#new'
  get "/logout", to: 'sessions#destroy'
  resource :sessions, only: :create

  namespace :admin do
    resources :categories do
      resources :words, only: [:new, :create, :edit, :update, :destroy]
    end
  end
  get "/admin", to: "admin/categories#index"

  resources :lessons, only: [:create, :update, :index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
