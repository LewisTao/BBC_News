Rails.application.routes.draw do
  devise_for :authors, controller: { authors: 'api/v1/authors' }
  use_doorkeeper

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      resources :articles, only: [:show, :create, :index, :update, :destroy]
      resources :authors, only: [:index, :show, :destroy, :create]
    end

  end
end
