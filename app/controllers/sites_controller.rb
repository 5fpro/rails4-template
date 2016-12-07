# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  host       :string
#  subdomain  :string
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SitesController < ApplicationController
  before_action :find_site, only: [:show, :edit, :update, :destroy]
  
  def index
  	@sites = Site.all
  end
  
  def show
  	@pages = @site.pages
  	if params[:id] && params[:page_id]
			@page = Page.find(params[:page_id])
			@url = page_path(@page.slug)
			@action = "patch"
			@submit_name = "Update"
		else
			@page = @site.pages.build
			@url = pages_path
			@action = "post"
			@submit_name = "Create"
		end
  end

  def new
  	@site = Site.new
  end

  def create 
  	unless request.host == 'localhost'
			respond_error("not find site", 404)
		else
			@site = Site.new(site_params)

	  	if @site.save
	  		flash[:notice] = "success to create"
	      redirect_to site_path(@site)
	  	else
	  		flash[:alert] = "failed to create"
	      render :new
	  	end
		end
  end

  def edit
  	
  end

  def update
  	
  	if @site.update(site_params)
  	 	flash[:notice] = "success to update"
      redirect_to site_path(@site)
    else
  	 	flash[:alert] = "failed to update"
      render :edit
    end

  end

  def destroy
  	@site.destroy
  	flash[:notice] = "success to delete"
  	redirect_to sites_path
  end


  private

  def find_site
    @site = Site.find(params[:id])
  end

  def site_params
		params.require(:site).permit(:name, :host, :data)
	end

end
