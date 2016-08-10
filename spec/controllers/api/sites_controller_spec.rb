require 'rails_helper'

RSpec.describe Api::SitesController, type: :request do
  describe "#index" do
    before { FactoryGirl.create(:site) }

    subject do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it { expect(subject["sites"].size).to be > 0 }

    it "http status" do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    before(:all) do
      @site_params = {name: "1234",host: "123", subdomain: "999db"}
    end

    it "creates record" do
      expect{ post "/api/sites", post:  @site_params }.to change{Site.all.size}.by(1)
    end

  end
end
