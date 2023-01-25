# frozen_string_literal: true

module Users
  module Commands
    class Authorize < Base
      attr_reader :user

      def initialize(token) # rubocop:disable Lint/MissingSuper
        @token = token
      end

      def call
        find_user
      rescue JWT::ExpiredSignature
        errors.add(:token, I18n.t('errors.token.expired'))
      rescue JWT::DecodeError
        errors.add(:token, I18n.t('errors.token.invalid'))
      end

      private

      attr_reader :token

      def find_user
        @user = User.find_by(id: user_id)

        errors.add(:user, I18n.t('errors.user.not_found', id: user_id)) unless @user
      end

      def payload
        @payload ||= Auth::Jwt.decode(token)
      end

      def user_id
        payload[:user_id]
      end
    end
  end
end
