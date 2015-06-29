Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      devise_for :authors, :controllers => {:registrations => "api/v1/authors"}
      resources :authors, only: [:index, :show]
    end

  end
end
