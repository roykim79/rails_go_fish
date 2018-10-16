Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :games, only: [:index, :show, :update] do
    resources :game_users, only: [:create]
  end
  root 'sessions#new'
end
