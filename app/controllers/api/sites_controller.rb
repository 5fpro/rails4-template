module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def create
      @site = Site.new(:name => params[:name], :host => params[:host])

      if @site.save
        render :json => {:id => @site.id, :message => "Created"}
      else
        render :json => {:message => "Invalid", :errors => @site.errors}, :status => 400
      end
    end

    def update
        @site = Site.find(params[:id])
      if @site.update(:name => params[:name], :host => params[:host])
        render :json => {:id => @site.id, :message => "Updated"}
      else
        render :json => {:message => "Invalid", :errors => @site.errors}, :status => 400
      end
    end

    def delete
      @site = Site.find(params[:id])
      @site.destroy
      render :json => {:message => "Delete successfully"}
    end

  end
end
