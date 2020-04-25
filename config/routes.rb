Rails.application.routes.draw do
  devise_for :users, only: []

  devise_scope :users do
    scope :auth, defaults: { format: :json } do
      post   '/signin',       to: 'sessions#create'
      delete '/signout',      to: 'sessions#destroy'
    end
  end
end
