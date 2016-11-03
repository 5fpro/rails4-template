module Api
  class BaseController < ActionController::Base
    def index
      @message = "api root"
    end
  end
end
