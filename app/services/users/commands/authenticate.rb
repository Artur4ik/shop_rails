# frozen_string_literal: true

module Users
  module Commands
    class Authenticate < Base
      validate :check_email
      validate :check_password

      def initialize(email, password) # rubocop:disable Lint/MissingSuper
        @email = email
        @password = password
      end

      def call
        token if valid?
      end

      def token
        @token ||= {
          token: Auth::Jwt.encode(payload),
          exp:
        }
      end

      private

      attr_reader :email, :password

      def check_email
        errors.add(:email, 'Invalid user email') unless user
      end

      def check_password
        errors.add(:password, 'Invalid user password') if valid_email? && invalid_password?
      end

      def valid_email?
        errors[:email].empty?
      end

      def invalid_password?
        !user.authenticate(password)
      end

      def user
        @user ||= ::User.find_by(email:)
      end

      def payload
        {
          user_id: user.id,
          exp:
        }
      end

      def exp
        12.hours.from_now.to_i
      end
    end
  end
end
