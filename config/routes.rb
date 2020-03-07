Rails.application.routes.draw do
  root to: "home#index"

  resources :communities, only: %i( index show ) do
    resources :questions, only: %i( index show ) do
      resources :answers, only: %i( create )
      post "vote_up", to: "questions#vote_up"
      post "vote_down", to: "questions#vote_down"
      post "remove_vote", to: "questions#remove_vote"
    end
  end

  resources :gardens do
    get "/markets/new/:id", to: "markets#new", as: "market_new"
    resources :markets, only: %i( edit update create ) do
      get "set_active", to: "markets#set_active"
      get "/market_notifications/status", to: "market_notifications#status", as: "market_notification_status"
      resources :market_notifications, only: %i( new create )
    end
    resources :garden_varieties, only: %i( new create ) do
      get "set_active", to: "garden_varieties#set_active"
    end
  end

  resources :users, only: %i( show )

  devise_for :users, path: "auth"
end
