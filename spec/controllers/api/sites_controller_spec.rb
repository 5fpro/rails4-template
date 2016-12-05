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

    context "create failed zh-TW" do
      
      subject do
        post "/api/sites", nil, { 'Accept-Language' => 'zh-TW' }
        JSON.parse(response.body)
      end

      it { expect(subject["error_message"]["name"]).to eq(["不能是空白字元"]) }

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

    context "update failed zh-TW" do
      let!(:site){ FactoryGirl.create(:site) }
      
      subject do
        patch "/api/sites/#{site.id}", nil, { 'Accept-Language' => 'zh-TW' }
        JSON.parse(response.body)
      end

      it { expect(subject["error_message"]["name"]).to eq(["不能是空白字元"]) }

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

  describe "#bulk_update" do
    let!(:site1){ FactoryGirl.create(:site) }
    let!(:site2){ FactoryGirl.create(:site) }
    let!(:site3){ FactoryGirl.create(:site) }
    
    context "have ids" do
      
      subject do
        post "/api/sites/bulk_update", { ids: [ site1.id, site2.id ] }
        JSON.parse(response.body)
      end

      it { expect(subject["message"]).to eq("destroy success") }
      it { expect(subject["status"]).to eq(200) }

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end

    end

    context "have not ids" do
      
      subject do
        post "/api/sites/bulk_update"
        JSON.parse(response.body)
      end

      it { expect(subject["message"]).to eq("You don't destroy any data") }
      it { expect(subject["status"]).to eq(200) }

      it "http status" do
        subject
        expect(response.status).to eq(200)
      end
      
    end

  end

end
