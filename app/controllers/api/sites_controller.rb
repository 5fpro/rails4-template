module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end


    def create
      @site = Site.new(site_params)
      if @site.save
        result = @site
        status = 200
      else
        result = nil
        status = 400
      end

      render :json => result.to_json, :status => status
    end

    def update
      @site = Site.find(params[:id])

      if @site.update(site_params)
        result = @site
        status = 200
      else
        result = nil
        status = 400
      end

      render :json => result.to_json, :status => status

    end


    protected

    def site_params
      params.require(:site).permit(:name, :host, :subdomain, :data)
    end

  end
end
