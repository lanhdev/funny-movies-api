# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :sessions, path: '', controllers: { sessions: 'sessions' }

  resources :movies, defaults: { format: :json }, only: %i[index create] do
    resources :comments, only: %i[index create]
    resources :ratings, only: %i[create]
  end

  resources :ratings, only: %i[destroy]
end
