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
  before_filter :find_subdomain_site, :only => :show

  def show
  end

  def edit
  end

  private


  def find_subdomain_site

    @site = Site.find_by_subdomain(request.host.split('.').first)
  end

end
