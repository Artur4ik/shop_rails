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
        errors.add(:email, raw_invalid_email_error) unless user
      end

      def check_password
        errors.add(:password, raw_invalid_password_error) if valid_email? && invalid_password?
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

      def raw_invalid_email_error
        I18n.t('activerecord.errors.models.user.attributes.email.invalid')
      end

      def raw_invalid_password_error
        I18n.t('activerecord.errors.models.user.attributes.password.invalid')
      end
    end
  end
end
