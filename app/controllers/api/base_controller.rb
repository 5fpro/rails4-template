module Api
  class BaseController < ApplicationController
		skip_before_action :verify_authenticity_token
		before_action :enable_cors
		
    def index
      @message = "api root"
    end

    private

	  def enable_cors
	    response.headers['Access-Control-Allow-Origin'] = '*'
	    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
	    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
	    response.headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
	    response.headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
	    #防止catch 回覆時塞最後的時間回去
	    response.headers['Last-Modified'] = '#{Time.now}'

	  end
  end
end
