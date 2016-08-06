module Api
  class SitesController < ::Api::BaseController
    before_action :set_site, only: [:update, :delete]
    def index
      @sites = Site.all
    end

    def create
      @site = Site.new(site_params)

      if @site.save
        render json: { status: 200 }.to_json
      else
        render json: { status: 400, errors: @site.errors }.to_json
      end
    end

    def update
      if @site.update(site_params)
        render json: { status: 200 }.to_json
      else
        render json: { status: 400, errors: @site.errors }.to_json
      end
    end

    def destroy
      @site.destroy
    end

    private

    def set_site
      @site = Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, :host, :subdomain, :data)
    end

  end
end
