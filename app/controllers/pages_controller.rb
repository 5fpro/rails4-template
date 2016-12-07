# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  slug       :string
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PagesController < ApplicationController
	before_action :set_site
	before_action :set_pages
	before_action :set_page, :only => [:update, :destroy, :show]
	
	def show

	end

	def create
		@page = @site.pages.build(page_params)

		if @page.save
			flash[:notice] = "success to create"
		else
			flash[:alert] = "failed to create"
			@url = site_pages_path(@site)
			@action = "post"
			@submit_name = "Create"
		end
		redirect_to site_path(@site)
		# respond_to do |format|
		# 	format.js
		# end

	end

	def update
		if @page.update(page_params)

			flash[:notice] = "success to update"
			
		else
			@url = site_page_path(@site, @page)
			@action = "patch"
			@submit_name = "Update"
			flash[:alert] = "failed to update"

		end
		redirect_to site_path(@site)
	end

	def destroy
		@page.destroy
		flash[:notice] = "success to delete"
		redirect_to site_path(@site)

		# respond_to do |format|
		# 	format.js
		# end
		
	end

	private

	def page_params
		params.require(:page).permit(:title, :body, :slug)
	end

	def set_pages
		@pages = @site.pages
	end
	
	def set_page
		@page = Page.find_by(slug: params[:slug])
		
		respond_error("not find page", 404) unless @page

	end

	def set_site
		@site = Site.find(params[:site_id])
	end
end
