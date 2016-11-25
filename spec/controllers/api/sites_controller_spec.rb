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
    it "should return 200 when successfully created" do
      post "/api/sites", :site => { :name => 'aaa', :host => 'bbb', :subdomain => 'ccc', :data => 'ddd' }
      expect(response.status).to eq(200)
    end

    it "should return 400 when failed to create" do
      post "/api/sites", :site => { :name => '' }
      expect(response.status).to eq(400)
    end
  end
end
