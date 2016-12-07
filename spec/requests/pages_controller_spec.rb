require 'rails_helper'

RSpec.describe PagesController, type: :request do
  # let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:site) { FactoryGirl.create(:site)}
  let!(:page) { site.pages.create(title: "title1", slug: "slug2", body: "body3") }
  let!(:page1) { site.pages.create(title: "title1", slug: "slug2", body: "body3") }


  describe "DELETE sites/:site_id/pages/:id", :type => :feature, js: true do
    
    it "ujs" do
      visit site_path(site)
      expect(page.html).to have_content "title1" 
      sleep(1)
      click_link 'destroy'
      sleep(1)
      expect(page.html).to have_content 'success to delete' 
    end

  end

end
