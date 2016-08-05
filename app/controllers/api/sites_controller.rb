module Api
  class SitesController < ::Api::BaseController

    skip_before_filter :verify_authenticity_token

    def index
      @sites = Site.all
    end

    def create

      @site = Site.new(name: params[:name],
                    host: params[:host],
                    subdomain: params[:subdomain],
                    data: params[:data])
      if @site.save
        @status = 200
      else
        @status = 400
      end

    end

    def update

      begin
        @site = Site.find(params[:id])

        if @site.update(name: params[:name] || @site.name,
                      host: params[:host] || @site.host,
                      subdomain: params[:subdomain] || @site.subdomain,
                      data: params[:data] || @site.data)

          @status = 200
        else
          @status = 400
        end

      rescue
        @status = 400
      end

    end

    def destroy

      begin
        @site = Site.find(params[:id])
        @site.destroy
        @status = 200
      rescue
        @status = 400
      end

    end

  end
end
