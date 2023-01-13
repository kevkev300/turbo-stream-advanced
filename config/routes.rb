Rails.application.routes.draw do
  root 'games#new'

  resources :games, only: %i[new create]
end
