require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do
  describe "GET /api.json" do
    subject do
      get "/api.josn"
      JSON.parse(response.body)
    end

    it { expect(subject["message"]).to be_present }
  end
end
