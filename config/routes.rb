Rails.application.routes.draw do
  get '', to: 'home#index'
  devise_for :users
end
