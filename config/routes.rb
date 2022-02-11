Rails.application.routes.draw do
  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'

  resources :users

  get "/login", to: 'sessions#new'
  get "/logout", to: 'sessions#destroy'
  resource :sessions, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
