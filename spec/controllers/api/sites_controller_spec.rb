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

    it "should return error message in json format when failed to create" do
      post "/api/sites", :site => { :name => '' }
      res = JSON.parse(response.body)
      expect(res['error']).to eq("Name can't be blank")
    end

  end

  describe "#update" do

    before do
      Site.create( :id => 1, :name => "aaa", :host => "bbb", :subdomain => "ccc", :data => "ddd")
    end

    it "should update site name" do
      patch "/api/sites/1", :site => { :name => "updated" }
      site = Site.find(1)
      expect(site.name).to eq("updated")
    end

    it "should return 400 when failed to update" do
      patch "/api/sites/1", :site => { :name => "" }
      expect(response.status).to eq(400)
    end

    it "should return error message in json format when failed to update" do
      patch "/api/sites/1", :site => { :name => '' }
      res = JSON.parse(response.body)
      expect(res['error']).to eq("Name can't be blank")
    end

  end

  describe "#destroy" do

    before do
      Site.create( :id => 1, :name => "aaa", :host => "bbb", :subdomain => "ccc", :data => "ddd")
    end

    it "should return 200 when successfully deleted" do
      delete "/api/sites/1"
      expect(response.status).to eq(200)
    end
  end
end
