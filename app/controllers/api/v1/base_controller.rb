# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      protected

      def render_errors(errors, status)
        render json: { errors: }, status:
      end
    end
  end
end
