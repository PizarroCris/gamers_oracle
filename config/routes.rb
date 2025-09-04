Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"

  resources :games do
    resources :chats
  end

  resources :chats do
    resources :messages, only: [:create]
  end
end
