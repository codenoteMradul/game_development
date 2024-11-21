Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :game
  post 'game/check_sum', to:'game#check_sum', as:'game_check_sum'

  root "users#index"
  resources :loggins, only: [:new,:create]
  resources :invitations, only: [:index,:new,:create]

  resources :games do
    collection do 
      # get 'index',to: "games#index"
      get 'start',to: "games#game"
      get 'game_over',to: "games#lose"
      get 'leaderboard',to: "games#leaderboard"
      get 'eventlog',to: "games#eventlog"
      get 'final_point',to: "games#point"
    end
  end

  resources :users do
    collection do
     get 'points',to: "users#point"  
     get 'rules',to: "users#rules"
     get 'delete',to: "users#destroy"
    end
  end 

end
  