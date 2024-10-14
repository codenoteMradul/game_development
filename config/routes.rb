Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "users#index"
  resources :users
  resources :loggins
  resources :games
  get 'show',to: "loggins#show"
  get 'points',to: "users#point"
  get 'index',to: "games#index"
  get 'start',to: "games#game"

  # resources :loggins

  # get 'create',to:"loggins#create"

  # get 'users',to: "users#index"
  # get 'users_new',to: "users#new"
  # post 'users',to: "users#create"

  # Defines the root path route ("/")
  # root "posts#index"
end
