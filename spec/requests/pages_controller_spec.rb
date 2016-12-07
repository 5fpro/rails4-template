require 'rails_helper'

RSpec.describe PagesController, type: :request do
  # let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:site) { FactoryGirl.create(:site)}
  let!(:page) { site.pages.create(title: "title", slug: "slug", body: "body") }


  describe "POST sites/:site_id/pages" do
    
    before(:each) { signin_user }

    context "create page success" do
      
      before(:each) do
        
        data = {
          "page" => {
            "title" => "aaa",
            "slug" => "bbb"
          }
        }
        
        post "/sites/#{site.id}/pages", data 
      
      end
      
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(site_url(site)) }
      it { expect(flash[:notice]).to eq("success to create") }
      it do 
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("success to create")
      
      end

    end

    context "create page failed" do
      
      before(:each) { post "//sites/#{site.id}/pages", { "page" => { "title" => "" } } }

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(site_url(site)) }
      it{ expect(flash[:alert]).to eq("failed to create") }
      it do 
        
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("failed to create")
      
      end
    
    end
  
  end

  describe "PATCH sites/:site_id/pages/:slug" do
  
    before(:each) { signin_user }

    context "update page success" do
      
      before(:each) do
        
        data = {
          "page" => {
            "name" => "aaa"
          }
        }
        
        patch "/sites/#{site.id}/pages/#{page.slug}", data 
      
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

    context "update page failed" do
      
      before(:each) { patch "/sites/#{site.id}/pages/#{page.slug}", { "page" => { "title" => "" } } }

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(site_url(site)) }
      it{ expect(flash[:alert]).to eq("failed to update") }
      
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("failed to update")
      
      end
    end
  
  end

  describe "DELETE sites/:site_id/pages/:slug" do
    
    before(:each) { signin_user }
    before(:each) { delete "/sites/#{site.id}/pages/#{page.slug}" }

    context "destroy page success" do

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:notice]).to eq("success to delete") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to delete")
      
      end

    end

  end

  describe "GET sites/:site_id/pages/:slug" do
    
    before(:each) { signin_user }
    before(:each) { get "/sites/#{site.id}/pages/#{page.slug}" }

    context "show site success" do
    
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("pages/show") }
      it{ expect(response.body).to include("#{page.title}") }

    end 

    context "show site failed" do

      before(:each) { signin_user }
      before(:each) { get "/sites/#{site.id}/pages/#{page.id}" }

      it{ expect(response).to have_http_status(404) }
      it{ expect(response.body).to include("not find page") }

    end

  end

end
