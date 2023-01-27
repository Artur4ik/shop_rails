# frozen_string_literal: true

module Api
  module V1
    class AuthsController < BaseController
      def create
        authenticate.call

        if authenticate.success?
          render json: authenticate.token, status: :ok
        else
          render json: { errors: authenticate.errors }, status: :unauthorized
        end
      end

      private

      def authenticate
        @authenticate ||= Users::Commands::Authenticate.new(email, password)
      end

      def email
        user_params[:email]
      end

      def password
        user_params[:password]
      end

      def user_params
        @user_params ||= params.require(:user)
      end
    end
  end
end
