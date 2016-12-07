class PagesController < ApplicationController
	before_action :find_page , :only => [:edit,:destroy]
	def index
		@pages = Page.all	
	end

	def create
		@site = Site.find(params[:site_id])
		@page = @site.page.new(page_params)
		@page.save
	end

	def edit
		@page.update(page_params)
	end

	def destroy
		@page.destroy
	end

	private

	def find_page
		@page = Page.find(params[:id])
	end

	def page_params
		params.require(:page).permit(:title,:body,:slug)
	end

end
