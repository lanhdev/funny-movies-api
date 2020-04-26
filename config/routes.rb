Rails.application.routes.draw do
  devise_for :users, only: :sessions, path: '', controllers: { sessions: 'sessions' }

  resources :movies, defaults: { format: :json }, only: %i(index create)
end
