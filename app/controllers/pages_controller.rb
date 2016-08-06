class PagesController < ApplicationController

  before_action :set_site

  def show
    @page = @site.pages.find(params[:id])
  end

  def new
    @page = @site.pages.new
  end

  def create
    @page = @site.pages.new(page_param)
    if @page.save
      redirect_to site_path(@site)
    else
      render 'new'
    end
  end

  def edit
    @page = @site.pages.find(params[:id])
  end

  def update
    @page = @site.pages.find(params[:id])

    if @page.update(page_param)
      redirect_to site_path(@site)
    else
      render 'edit'
    end
  end

  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy

    flash[:alert] = "delete success"

    redirect_to site_path(@site)
  end

  protected

  def set_site
    @site = Site.find(params[:site_id])
  end

  def page_param
    params.require(:page).permit(:title, :body, :slug)
  end

end
