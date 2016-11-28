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
    
    context "create success" do
      
      subject do
        post "/api/sites", name: "123"
        JSON.parse(response.body)
      end

      it { expect(subject["site"]["name"]).to eq("123") }
      it { expect(subject["status"]).to eq(200) }

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end
    
    end

    context "create failed" do
      
      subject do
        post "/api/sites"
        JSON.parse(response.body)
      end

      it { expect(subject["error_message"]["name"]).to eq(["can't be blank"]) }
      it { expect(subject["status"]).to eq(400) }

      it "http status" do
        subject
        expect(response.status).to eq(400)
      end

    end

  end


  describe "#update" do
    
    context "update success" do
      let!(:site){ FactoryGirl.create(:site) }

      subject do
        patch "/api/sites/#{site.id}", name: "456"
        JSON.parse(response.body)
      end

      it { expect(subject["site"]["name"]).to eq("456") }
      it { expect(subject["status"]).to eq(200) }

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end
    
    end

    context "update failed" do
      let!(:site){ FactoryGirl.create(:site) }
      
      subject do
        patch "/api/sites/#{site.id}"
        JSON.parse(response.body)
      end

      it { expect(subject["error_message"]["name"]).to eq(["can't be blank"]) }
      it { expect(subject["status"]).to eq(400) }

      it "http status" do
        subject
        expect(response.status).to eq(400)
      end

    end

  end


  describe "#destroy" do
    let!(:site){ FactoryGirl.create(:site) }
 
    subject do
      delete "/api/sites/#{site.id}"
      JSON.parse(response.body)
    end

    it { expect(subject["message"]).to eq("destroy success") }
    it { expect(subject["status"]).to eq(200) }

    it "http status" do
      subject
      expect(response.status).to eq(200)
    end
    
  end

end
