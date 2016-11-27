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
        render :status => 400, :json => { :error => @site.errors.full_messages.join(",") }
      end
    end

    def update
      @site = Site.find(params[:id])
      if @site.update(params_site)
        render :json => @site, :status => 200
      else
        render :status => 400, :json => { :error => @site.errors.full_messages.join(",") }
      end
    end

    def destroy
      @site = Site.find(params[:id])
      @site.destroy
      render :json => { :message => "site deleted!"}, :status => 200
    end

    private
    def params_site
      params.require(:site).permit(:name, :host, :subdomain, :data)
    end
  end
end
