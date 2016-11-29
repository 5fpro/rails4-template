module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
      render json: { sites: JSON.parse( @sites.to_json ) }
    end

    def create
    	@site = Site.new(name: params[:name], subdomain: params[:subdomain], host: params[:host])

    	if @site.save
    		render json: @site.to_api(I18n.t(:create))
    	else
    		response.status = 400
    		render json: @site.error_message(I18n.t(:create))
    	end
    end

    def update
    	@site = Site.find(params[:id])

    	if @site.update(name: params[:name], subdomain: params[:subdomain], host: params[:host])
    		render json: @site.to_api(I18n.t(:update))
    	else
    		response.status = 400
    		render json: @site.error_message(I18n.t(:update))
    	end
    end

    def destroy
    	@site = Site.find(params[:id])
    	
    	@site.destroy
    	render json: { status: 200, message: I18n.t("message.success", action: I18n.t(:destroy)) }
    end
  end
end
