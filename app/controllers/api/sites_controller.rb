module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def create
    	@site = Site.new( name: params[:name], host: params[:host], subdomain: params[:subdomain], data: params[:data] )
      if @site.save
        render json: {message: "OK"}, status: 200
      else
        render json: {message: "Failed!"}, status: 400
      end
    end

    def update
    	@site = Site.find(params[:id])
    	if @site.update( name: params[:name], host: params[:host], subdomain: params[:subdomain],data: params[:data] )
        render json: {message: "OK"}, status: 200
      else
        render json: {message: "Failed!"}, status: 400
      end
    end

    def delete
    	@site = Site.find(params[:id])
    	@site.destroy
    end
  end
end
