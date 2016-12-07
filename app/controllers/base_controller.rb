class BaseController < ApplicationController

  def index
    if request.host == 'localhost'
    	set_meta(title: "Myapp Admin")
    elsif @site = Site.find_by(host: request.host) 
    	set_meta(title: request.host)
    	@page = @site.pages.build
			@url = pages_path(@site)
			@action = "post"
			@submit_name = "Create"
			@pages = @site.pages
    	render 'sites/show'
    else
			respond_error("not find host", 404)
    end
  end
end
