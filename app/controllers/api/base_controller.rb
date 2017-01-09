class Api::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :respond_record_not_found

  before_action :enable_cors
  before_action :default_format_josn
  before_action :client_auth
  skip_before_action :verify_authenticity_token

  def error_404
    respond_error messages: "/#{params[:unmatched_route]} not found", status: 404
  end

  private

  def enable_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
  end

  def default_format_josn
    request.format = 'json' if request.format.to_s == 'text/html'
  end

  def respond_record_not_found(e)
    respond_error(messages: e.message, status: 404, debug: e.backtrace)
  end

  def respond_error(messages: nil, status: 400, debug: nil)
    render json: { error: true, messages: messages, debug: debug }, status: status
  end

  def client_auth
    respond_error unless request.headers.to_h["HTTP_X_TOKEN"] == "123456"
  end
end
