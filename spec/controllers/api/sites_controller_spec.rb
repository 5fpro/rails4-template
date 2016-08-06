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
    it "should save successfully" do
      post "/api/sites", :name => "AAA", :host => "BBB"
      parsed_json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_json).to eq({
        "id" => Site.last.id,
        "message" => "Created"
        })
    end

    it "should save failed" do
      post "/api/sites"
      parsed_json = JSON.parse(response.body)
      expect(response.body).to eq(400)
    end
  end

  describe "#update" do
    it "should udpate successfully" do
      patch "/api/sites/#{site.id}", :name => "CCC"
      parsed_json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_json).to eq({
        "name" => "CCC"
        "message" => "Updated"
        })
    end

    it "should update failed" do
      post "/api/sites"
      parsed_json = JSON.parse(response.body)
      expect(response.body).to eq(400)
    end
  end

  describe "#delete" do
    it "should delete successfully" do
      delete "/api/sites/#{site.id}"
      parsed_json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed_json).to eq({
        "message" => "Delete successfully"
        })
    end
  end



end
