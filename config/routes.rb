Rails.application.routes.draw do
  root "weather#index"

  resources :weather, only: [:index]
end
