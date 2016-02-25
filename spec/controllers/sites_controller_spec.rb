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

require 'rails_helper'

RSpec.describe SitesController, type: :request do
  let!(:site) { Site.create!(:name=>"aron",:host=>"example1227.com") }
  
  describe "#show in normal way" do
    before { get "http://#{Setting.host}/sites/#{site.id}" }
    it { expect(response).to be_success }
  end

  describe "#show via customer subdomain" do
    before { get "http://#{site.subdomain}.#{Setting.host}" }
    it { expect(response).to be_success }
  end

  describe "#show via customer domain" do
    it "assigns site" do
    	host!(site.host)
      get "/"
      expect(assigns(:site).id).to eq(site.id)
    end
  end

  describe "#edit in normal way" do
    before { get "http://#{Setting.host}/sites/#{site.id}/edit" }
    it { expect(response).to be_success }
  end
  
  describe "#edit via customer subdomain" do
    before { get "http://#{site.subdomain}.#{Setting.host}/edit" }
    it { expect(response).to be_success }
  end  

  describe "#edit via customer domain" do
    it "assigns site" do
    	host!(site.host)
      get "/edit"
      expect(assigns(:site).id).to eq(site.id)
    end
  end

end
