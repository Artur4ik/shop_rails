# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      include Api::V1::Concerns::Users

      def show
        render json: @user,
               serializer: Api::V1::UserSerializer,
               status: :ok
      end

      def create
        @user = User.new(strong_user_params)

        if @user.save
          render json: @user,
                 serializer: Api::V1::UserSerializer,
                 status: :created
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(update_user_params)
          render json: @user,
                 serializer: Api::V1::UserSerializer,
                 status: :ok
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          render json: @user,
                 serializer: Api::V1::UserSerializer,
                 status: :ok
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      private

      def strong_user_params
        @strong_user_params ||= params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :birthdate, :address)
      end

      def update_user_params
        strong_user_params.slice(:email, :first_name, :last_name, :birthdate, :address)
      end
    end
  end
end
