# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale!

  def set_locale!
    I18n.locale = locale if locale.in?(I18n.available_locales)
  end

  def locale
    request.headers.fetch('Accept-Language', 'en').to_sym
  end
end
