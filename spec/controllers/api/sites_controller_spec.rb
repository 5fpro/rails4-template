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

    let(:site_index) do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it "should get 1 data after create site" do

      post "/api/sites", :site => { :name => "AA", :host => "BB", :subdomain => "CC", :data => "DD"}

      expect(site_index["sites"].size).to be(1)

    end

    it "should get 400 status while create site failed" do

      post "/api/sites", :site => { :host => "BB", :subdomain => "CC", :data => "DD"}

      expect(response.status).to eq(400)
    end


  end


  describe "#update" do

    before { Site.create(:id => 1, :name => "AA", :host => "BB", :subdomain => "CC") }

    it "should update name from AA to aa" do

      expect(Site.find(1).name).to eq("AA")

      patch "/api/sites/1", :site => {:name => "aa"}

      expect(Site.find(1).name).to eq("aa")

    end

  end
end
