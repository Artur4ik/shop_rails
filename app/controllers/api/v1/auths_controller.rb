# frozen_string_literal: true

module Api
  module V1
    class AuthsController < ApplicationController
      def create
        if authenticate.success?
          render json: authenticate.token, status: :ok
        else
          render json: authenticate.errors, status: :unauthorized
        end
      end

      private

      def authenticate
        @authenticate ||= Auth::Commands::Authenticate.call(email, password)
      end

      def email
        user_params[:email]
      end

      def password
        user_params[:password]
      end

      def user_params
        @user_params ||= params[:user]
      end
    end
  end
end
