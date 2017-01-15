module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def batch_delete

      params[:ids].each do |id|
        site = Site.find_by(:id => id)
        site.destroy
      end

      render :json => nil, :status => 200
    end
  end
end
