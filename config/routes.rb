Rails.application.routes.draw do
  root 'home#welcome'

  devise_for :users
  resources :entries
end
