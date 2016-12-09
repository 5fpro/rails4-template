module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def create
    	@site = Site.new(site_params)
    	if@site.save
    		render :json => @site.to_json, :status =>200
    		
    	else
    		render :json => @site.errors.to_json, :status =>400
    	end	
    end

    def update
    	@site = Site.find(params[:id])
    	if @site.update(site_params)
    		render :json => @site.to_json, :status =>200
    	else
    		render :json => @site.errors.to_json, :status =>400
    	end
    end

    def destroy
    	@site = Site.find(params[:id])
    	@site.destroy
    	render :json => {:message => "delete completed"}, :status =>200
    end

    def bulk_delete
       ids = Array(params[:sites_ids])
       delete_sites = ids.map{ |id| Site.find_by_id(id) }.compact
       delete_sites.each{ |site| site.destroy }
       render :json => { :message => "delete sites"}, :status => 200
     end

  private

	  def site_params
	  	params.require(:site).permit(:name,:host,:subdomain,:data)
	  end

  end
end
