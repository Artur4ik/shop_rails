# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :auth, only: %i[create]
      resource :user, only: %i[show create update destroy]
      resources :product_categories, only: %i[index] do
        resources :products, only: %i[index show]
      end
    end
  end
end
