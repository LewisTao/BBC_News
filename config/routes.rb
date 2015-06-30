Rails.application.routes.draw do
  devise_for :authors
  use_doorkeeper

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      resources :articles, only: [:show, :create, :index]
      resources :authors, only: [:index, :show]
      resources :sessions, only: [:create, :destroy]
    end

  end
end
