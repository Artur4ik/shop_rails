# frozen_string_literal: true

module Auth
  class Jwt
    class << self
      DEFAULT_SECRET_KEY = 'secret'

      def encode(payload)
        JWT.encode(payload, fetch_secret_key_base, 'HS256')
      end

      def decode(token)
        body, = JWT.decode(token, fetch_secret_key_base,
                           true, algorithm: 'HS256')
        HashWithIndifferentAccess.new(body)
      rescue JWT::ExpiredSignature
        nil
      end

      private

      def fetch_secret_key_base
        Rails.application.secrets.secret_key_base || DEFAULT_SECRET_KEY
      end
    end
  end
end
