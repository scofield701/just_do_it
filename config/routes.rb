Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root "homes#index"

  devise_for :users, :controllers => {
   :registrations => 'users/registrations'
  }

  resources :users, only: [:index, :show] do
    get  :search,        on: :collection
    get  :search_result, on: :collection
  end

  resources :favorites, only: :create do
    get :following,     on: :collection
    get :follower,      on: :collection
  end

  resources :matching,  only: :index
  resources :chat,      only: [:create, :show]
end
