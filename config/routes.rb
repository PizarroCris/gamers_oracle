Rails.application.routes.draw do
  devise_for :users

  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check

  # Home
  root to: "pages#home"

  # Chats + AI endpoint
  resources :chats do
    member do
      post :ask_ai
    end
  end

  # Games
  resources :games
end
