# frozen_string_literal: true

module Auth
  module Commands
    class Authenticate < Base
      attr_reader :token

      def initialize(email, password) # rubocop:disable Lint/MissingSuper
        @email = email
        @password = password
      end

      private

      attr_reader :email, :password

      def run_command
        errors.add(:email, 'Invalid user email') && return unless email_valid?
        errors.add(:password, 'Invalid user password') && return unless password_valid?

        @token = {
          token: Auth::Jwt.encode(payload),
          exp:
        }
      end

      def email_valid?
        user
      end

      def password_valid?
        user.authenticate(password)
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
        24.hours.from_now.to_i
      end
    end
  end
end
