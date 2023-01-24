# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :auth, only: %i[create]
      resource :user, only: %i[show create update destroy]
    end
  end
end
