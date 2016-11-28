module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
      render json: { sites: JSON.parse( @sites.to_json ) }
    end

    def create
    	@site = Site.new(name: params[:name], subdomain: params[:subdomain], host: params[:host])

    	if @site.save
    		render json: @site.to_api
    	else
    		response.status = 400
    		render json: @site.error_message
    	end
    end

    def update
    	@site = Site.find(params[:id])

    	if @site.update(name: params[:name], subdomain: params[:subdomain], host: params[:host])
    		render json: @site.to_api
    	else
    		response.status = 400
    		render json: @site.error_message
    	end
    end

    def destroy
    	@site = Site.find(params[:id])
    	
    	@site.destroy
    	render json: { status: 200, message: "destroy success" }
    end
  end
end
