Rails.application.routes.draw do
  get "", to: "home#index"

  resources :communities, only: %i( index show ) do
    resources :questions, only: %i( index show )
  end

  devise_for :users, path: "auth"
end
