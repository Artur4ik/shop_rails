# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :check_content_type

      CONTENT_TYPE = 'application/json'

      rescue_from ActionController::ParameterMissing do |exception|
        render_errors(raw_param_missing_error(exception.param), :bad_request)
      end

      protected

      def render_errors(errors, status)
        render json: { errors: [errors].flatten }, status:
      end

      private

      def check_content_type
        render_errors(raw_accept_error, :not_acceptable) && return unless accept == CONTENT_TYPE

        render_errors(raw_content_type_error, :not_acceptable) unless content_type == CONTENT_TYPE
      end

      def accept
        request.headers.fetch('Accept', '')
      end

      def content_type
        request.headers.fetch('Content-Type', '')
      end

      def raw_accept_error
        I18n.t('errors.api.accept')
      end

      def raw_content_type_error
        I18n.t('errors.api.content_type')
      end

      def raw_param_missing_error(param)
        I18n.t('errors.api.param_missing', param:)
      end
    end
  end
end
