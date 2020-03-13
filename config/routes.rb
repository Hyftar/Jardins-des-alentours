Rails.application.routes.draw do
  root to: "home#index"

  scope "admin" do
    get "", to: "admin#home", as: "admin"
    scope "roles" do
      get "", to: "roles#index", as: "roles"
      post "", to: "roles#search"
      post "set_role", to: "roles#set_role"
    end
  end

  resources :communities, only: %i( index show ) do
    resources :questions, only: %i( index show new create update destroy ) do
      post "vote_up", to: "questions#vote_up"
      post "vote_down", to: "questions#vote_down"
      post "remove_vote", to: "questions#remove_vote"
      post "select_answer", to: "questions#select_answer"
      resources :answers, only: %i( create update destroy ) do
        post "vote_up", to: "answers#vote_up"
        post "vote_down", to: "answers#vote_down"
        post "remove_vote", to: "answers#remove_vote"
      end
    end
  end

  resources :gardens do
    get "/markets/new/:id", to: "markets#new", as: "market_new"
    get "write_email", to: "markets#write_email"
    post "send_email", to: "markets#send_email"
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

  devise_for :users, path: "auth", controllers: { sessions: "users/sessions" }
end
