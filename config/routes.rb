Rails.application.routes.draw do
  get "", to: "home#index"

  resources :communities, only: %i( index show ) do
    resources :questions, only: %i( index show ) do
      resources :answers, only: %i( create )
      post "vote_up", to: "questions#vote_up"
      post "vote_down", to: "questions#vote_down"
      post "remove_vote", to: "questions#remove_vote"
    end
  end

  devise_for :users, path: "auth"
end
