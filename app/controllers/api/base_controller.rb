module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_locale
    before_action :enable_cors
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

    def enable_cors
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
      response.headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
      response.headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
    end
  end
end
