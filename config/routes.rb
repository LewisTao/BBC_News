Rails.application.routes.draw do
  devise_for :authors
  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      resources :authors, only: [:index]
    end

  end
end
