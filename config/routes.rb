Rails.application.routes.draw do
  devise_for :users
  resources :movies
  get 'movies/index'
  get 'rates/create'
  root "movies#index"
end
