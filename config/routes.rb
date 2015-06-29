Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      devise_for :authors, :controllers => {:registrations => "api/v1/authors"}
      resources :articles, only: [:show, :create]
      resources :authors, only: [:index, :show]
      resources :sessions, only: [:create, :destroy]
    end

  end
end
