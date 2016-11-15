require 'rails_helper'

describe ::Error, type: :lib do
  it '.raise' do
    expect {
      described_class.raise!(:data_not_found)
    }.to raise_error(::Errors::Exception)
  end
end

describe ::Error, type: :request do

  it "error message I18n" do
    
  	# subject do
  	# 	params = { id: "not_exist" }
   #    post "/sites", params
   #    JSON.parse(response.body)
  	# end

    expect {
      described_class.raise!(:data_not_found)
    }.to raise_error(::Errors::Exception)

    expect {
      described_class.raise!(:data_not_found)
    }.should == I18n.t("translation missing: en.data_not_found")

    # it "translation" do 
    # 	subject
	   #  expect(response.status).to eq(400)
    # end

    # it "confirm language" do 
    # 	subject
	   #  expect(response.request.env["HTTP_ACCEPT_LANGUAGE"].split(",").first).to eq("zh-TW")
    # end
  end
end
