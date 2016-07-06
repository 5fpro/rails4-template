module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end
  end
end
