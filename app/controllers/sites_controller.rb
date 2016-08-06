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
    @sites = Site.all("updated_at desc")
  end

  def show
    @pages = @site.pages.order("updated_at desc")
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:notice] = "site was successfully created"
      redirect_to :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @site.update(site_params)
      flash[:notice] = "update successfully"
      redirect_to :index
    else
      render :edit
    end
  end

  def destroy
    @site.destroy
    flash[:alert] = "The site was successfully deleted"
    redirect_to :index
  end

  protected

  def find_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:name, :host, :subdomain, data: Site.stored_attributes[:data])
  end
end
