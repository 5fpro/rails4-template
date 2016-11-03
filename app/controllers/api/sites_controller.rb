module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def create
    	@site = Site.new( name: params[:name], host: params[:host], subdomain: params[:subdomain],data: params[:data] )
        @site.save
    end

    def update
    	@site = Site.find(params[:id])
    	@site = Site.update( name: params[:name], host: params[:host], subdomain: params[:subdomain],data: params[:data] )
    end

    def delete
    	@site = Site.find(params[:id])
    	@site.destroy
    end
  end
end
