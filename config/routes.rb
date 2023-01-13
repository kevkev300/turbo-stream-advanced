Rails.application.routes.draw do
  get 'player/new'
  root 'games#new'

  resources :games, only: %i[show new create] do
    resources :players, only: %i[new create]
  end
end
