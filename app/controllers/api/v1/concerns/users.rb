# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module Users
        extend ActiveSupport::Concern

        included do
          before_action :authorize_user!, only: %i[show update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter

          def authorize_user!
            render_errors(invalid_token, :unauthorized) && return if bearer_token.blank?

            authorize.call
            render_errors(authorize.errors, :unauthorized) if authorize.fail?

            @user = authorize.user
          end

          def authorize
            @authorize ||= ::Users::Commands::Authorize.new(bearer_token)
          end

          def bearer_token
            request.headers.fetch('Authorization', '').gsub(/^[B|b]earer /, '')
          end

          def invalid_token
            {
              token: [I18n.t('errors.token.invalid')]
            }
          end
        end
      end
    end
  end
end
