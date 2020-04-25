Rails.application.routes.draw do
  devise_for :users, path: 'auth', controllers: { sessions: 'sessions' }
end
