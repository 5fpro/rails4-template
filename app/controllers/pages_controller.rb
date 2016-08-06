class PagesController < ApplicationController
  def show
    @site = Site.find(parmas[:id])
    @page = @site.pages.find_by(slug: 'test')

    if @page != nil
      not_found
    end
  end
end
