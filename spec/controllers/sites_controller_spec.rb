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
  let(:site) { FactoryGirl.create :site }
  let(:site) {Site.new(:name => "qwe", :subdomain => "abcd", :host => "www.appwe.com")}

  describe "GET site/show" do
    before { get "/" }
    it { expect(response).to render_template(:show)}
  end

  describe "#edit" do
    before { get "/sites/#{site.id}/edit" }
    it { expect(response).to be_success }
  end
end
