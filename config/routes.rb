Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root "homes#index"
  devise_for :users

  resources :users, only: [:index, :show] do
    member do
     get :following, :followers
    end
    get  :search,  on: :collection
  end

  resources :favorites, only: :create
  resources :matching,  only: :index
  resources :chat,      only: [:create, :show]
end
