Rails.application.routes.draw do
  devise_for :authors, :controllers => {:registrations => "api/v1/authors"}
  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      resources :authors, only: [:index, :show]
    end

  end
end
