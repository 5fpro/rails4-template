module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
      render json: { sites: @sites.map{ |s| s.api_info}}
    end

    def create
      @site = Site.new(site_params)
      if @site.save
        render json:{
          status: 200,
          site: @site,
          message: "Site created succeed"
        }
      else
        render json:{
          status: 404,
          message: "Site created filed",
          error_messages: @site.errors
        }
      end
    end

    def update
      @site = Site.find(params[:id])
      if @site.update(site_params)
        render json:{
          status: 200,
          site: @site,
          message: "Site updated succeed"
        }
      else
        render json:{
          status: 404,
          message: "Site updated filed",
          error_messages: @site.errors

        }
      end
    end

    def destroy
      @site = Site.find(params[:id])
      if @site.destroy
        render json:{
           status: 200,
           message: "Site delete success"

        }
      else
        render json:{
          status: 404,
          message: "Site delete failed",
          error_messages: @site.errors
        }
      end
    end

    private

    def site_params
      params.require(:site).permit(:name, :host, :subdomain, :data)
    end
  end
end
