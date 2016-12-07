require 'rails_helper'

RSpec.describe SitesController, type: :request do
  # let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:site) { FactoryGirl.create(:site) }

  
  describe "GET /sites" do
  
    subject! { get "/sites" }
    
    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template("sites/index") }
  
  end

  describe "POST /sites" do
    
    before(:each) { signin_user }

    context "create site success" do
      
      before(:each) do
        
        data = {
          "site" => {
            "name" => "aaa"
          }
        }
        
        post "/sites", data 
      
      end
      
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(site_url(Site.last)) }
      it { expect(flash[:notice]).to eq("success to create") }
      it do 
        
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to create")
      
      end

    end

    context "create site failed" do
      
      before(:each) { post "/sites", { "site" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("sites/new") }
      it{ expect(flash[:alert]).to eq("failed to create") }
      it{ expect(response.body).to include("failed to create") }
    
    end
  
  end

  describe "PATCH sites/:id" do
  
    before(:each) { signin_user }

    context "update site success" do
      
      before(:each) do
        
        data = {
          "site" => {
            "name" => "aaa"
          }
        }
        
        patch "/sites/#{site.id}", data 
      
      end

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(site_url(site)) }
      it { expect(flash[:notice]).to eq("success to update") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to update")
      
      end
    
    end

    context "update site failed" do
      
      before(:each) { patch "/sites/#{site.id}", { "site" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("sites/edit") }
      it{ expect(flash[:alert]).to eq("failed to update") }
      it{ expect(response.body).to include("failed to update") }
    
    end
  
  end

  describe "DELETE sites/:id" do
    
    before(:each) { signin_user }
    before(:each) { delete "/sites/#{site.id}" }

    context "destroy site success" do

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:notice]).to eq("success to delete") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to delete")
      
      end

    end

  end

  describe "GET sites/:id" do
    
    before(:each) { signin_user }
    before(:each) { get "/sites/#{site.id}" }

    context "show site success" do
    
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("sites/show") }
      it{ expect(response.body).to include("#{site.name}") }

    end 

  end

end
