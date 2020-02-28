Rails.application.routes.draw do
  root to: "home#index"

  resources :community, only: [:index, :show]

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
