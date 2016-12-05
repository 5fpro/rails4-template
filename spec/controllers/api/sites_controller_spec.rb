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

    subject do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it "create sucess"do
      post "/api/sites" , :site => {:name => "name",:host => "host",:subdomain => "subdomain",:data =>"data"}
      expect(response.status).to eq(200)
    end
    
    it "create failed"do
      post "/api/sites" , :site => {:name => ''}
      expect(response.status).to eq(400)
    end

  end  

  describe '#update' do

    before {site = Site.create(:id => 2,:name => "name2",:host => "host2",:subdomain => "subdomain2",:data =>"data2")}

    subject do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it "update sucess"do
      patch "/api/sites/2" , :site => {:name => "name3",:host => "host3",:subdomain => "subdomain3",:data =>"data3"}
      expect(response.status).to eq(200)
      site = Site.find(2)
      expect(site.name).to eq("name3")
    end
    
    it "update failed"do
      patch "/api/sites/2" , :site => {:name => ''}
      expect(response.status).to eq(400)
      site = Site.find(2)
      expect(site.name).to eq("name2")
    end
    
  end 

  describe '#destroy' do

    before {site = Site.create(:id => 2,:name => "name2",:host => "host2",:subdomain => "subdomain2",:data =>"data2")}

    subject do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it "delete" do
      expect(Site.count).to eq(1)
      delete "/api/sites/2"
      expect(response.status).to eq(200)
      expect(Site.count).to eq(0)
    end

    
  end 

end
