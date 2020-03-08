Rails.application.routes.draw do
  root to: "home#index"

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

  resources :gardens, only: [:index, :show, :edit, :update, :destroy] do
    resources :markets, only: [:edit, :update] do
      get "set_active", to: "markets#set_active"
    end
    resources :garden_varieties, only: [] do
      get "set_active", to: "garden_varieties#set_active"
    end
  end

  resources :users, only: [:show]

  devise_for :users, path: "auth"
end
