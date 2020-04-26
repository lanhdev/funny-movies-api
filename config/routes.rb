Rails.application.routes.draw do
  devise_for :users, only: :sessions, path: '', controllers: { sessions: 'sessions' }
end
