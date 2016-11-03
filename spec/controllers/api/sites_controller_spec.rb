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

  describe "#create" do
    subject do
      params = { name: "xxx", host: "23433", subdomain: "subdomain333" }
      post "/api/sites.json", params
      JSON.parse(response.body)
    end

    it { expect(subject["message"]).to eq("OK") }

    it "check new subject name" do 
      subject 
      expect(Site.last.name).to eq("xxx") 
    end

    it "http status" do
      subject
      expect(response.status).to eq(200)
    end
  end
end
