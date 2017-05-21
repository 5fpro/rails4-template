class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include MetaTagHelper

  before_action :http_auth_for_staging
  before_action :set_paper_trail_whodunnit
  before_action :set_locale

  def default_url_options
    # SUPPORT: SSL
    # { protocol: "https" }
    {}
  end

  private

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == "myapp" && password == "myapp"
    end
  end

  def set_locale
    if request.headers["Accept-language"] && I18n.available_locales.include?( request.headers["Accept-language"].to_sym )
    session[:locale] = request.headers["Accept-language"]
    end
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
