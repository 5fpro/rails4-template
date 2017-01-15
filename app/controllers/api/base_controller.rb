module Api
  class BaseController < ApplicationController
    def index
      @message = "api root"
    end
  end
end
