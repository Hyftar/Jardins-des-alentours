Rails.application.routes.draw do
  get "", to: "home#index"

  resources :community, only: [:index, :show]

  devise_for :users, path: "auth"
end
