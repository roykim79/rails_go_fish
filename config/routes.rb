Rails.application.routes.draw do
  resources :sessions, only: [:create, :new]
  resources :games, only: [:index, :show]
  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
