# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'meetups/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resources :posts do
    resources :meetups
  end

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'
  # directs it to a method in sessions controller

  root 'posts#index'
end
