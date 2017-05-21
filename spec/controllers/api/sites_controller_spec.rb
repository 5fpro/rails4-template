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
    before { params = { site: {name: "www", host: "5f", subdomain: "tw"} }}
    context "create" do
      subject do
        post "/api/sites", site: { name: "www", host: "5f", subdomain: "tw" }
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
        post "/api/sites", site: {name: "", host: "5f", subdomain: "tw"}
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
    before { @site = FactoryGirl.create(:site)}

    context "update" do
      subject do
        put "/api/sites/#{@site.id}", site: {name: "www", host: "alphacamp", subdomain: "tw"}
        JSON.parse(response.body)
      end

      it {expect(subject["site"]["host"]).to eq("alphacamp")}
      it {expect(subject["status"]).to eq(200)}

      it "http status" do
        subject
        expect(response.status).to eq(200)

      end
    end

    context "update failed" do
      subject do
        put "/api/sites/#{@site.id}", site: {name: "", host: "alphacamp", subdomain: "tw"}
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
end
