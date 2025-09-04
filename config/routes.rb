Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"

  resources :chats do
    resources :messages, only: [:new, :create]
  end

  resources :games do
    resources :chats, only: [:index, :create]
  end
end
