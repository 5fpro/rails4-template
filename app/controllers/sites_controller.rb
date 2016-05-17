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
  before_action :find_site, :only => [:show, :edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)

    if @site.save
      redirect_to sites_path
    else
      render :action => :new
    end
  end

  def destroy
    @site.delete
    redirect_to sites_path
  end

  def show

     redirect_to @site.host

  end

  def update
    if @site.update(site_params)
      redirect_to sites_path
    else
      render :action => :update
    end
  end

  def edit
  end

  private

  def site_params
    params.require(:site).permit(:name, :host, :subdomain)
  end

  def find_site
    @site = Site.find(params[:id])
  end
end
