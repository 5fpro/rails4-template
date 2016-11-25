module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def create
      @site = Site.new(params_site)
      if @site.save
        render :json => @site.to_json, :status => 200
      else
        render :status => 400, :json => @site.errors.to_json
      end
    end

    private
    def params_site
      params.require(:site).permit(:name, :host, :subdomain, :data)
    end
  end
end
