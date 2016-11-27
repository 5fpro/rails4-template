module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_locale
    def index
      @message = "api root"
    end

    def set_locale
      I18n.locale = extract_locale_from_accept_language_header
    end

    private

    def extract_locale_from_accept_language_header
      locale = request.env['HTTP_ACCEPT_LANGUAGE'].split(',').first rescue I18n.default_locale
    end
  end
end
