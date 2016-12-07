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
    before { params = { site: {name: "www", host: "alphacamp", subdomain: "co"} }}

    context "create" do

      subject do 
        post "/api/sites", :site => {name: "www", host: "alphacamp", subdomain: "co"}
        JSON.parse(response.body)
      end

      it {expect(subject["site"]["name"]).to eq("www")}
      it {expect(subject["status"]).to eq(200)}

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end

    end

    context "create failed" do

      subject do 
        post "/api/sites", :site => {name: "", host: "alphacamp", subdomain: "co"}
        JSON.parse(response.body)
      end

      it {expect(subject["error_messages"]["name"]).to eq(["can't be blank"])}
      it {expect(subject["status"]).to eq(404)}

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end

    end
  end

  describe "#update" do
    before { FactoryGirl.create(:site) }
    
    context "update" do
      
      subject do
        patch "/api/sites/1", :site => {name: "www", host: "betacamp", subdomain: "co"}
        JSON.parse(response.body)
      end

      it {expect(subject["site"]["host"]).to eq("betacamp")}
      it {expect(subject["status"]).to eq(200)}

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end 
    end

    context "update failed" do
      
      subject do
        patch "/api/sites/1", :site => {name: "www", host: "betacamp", subdomain: ""}
        JSON.parse(response.body)
      end

      it {expect(subject["error_messages"]["subdomain"]).to eq(["can't be blank"])}
      it {expect(subject["status"]).to eq(404)}

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end 
    end
  end

  describe "#destroy" do
    before { FactoryGirl.create(:site) }
    
    context "destroy" do
      
      subject do
        delete "/api/sites/1"
        JSON.parse(response.body)
      end

      it {expect(subject["message"]).to eq("Site delete succeed")}
      it {expect(subject["status"]).to eq(200)}

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end 
    end
  end


end

