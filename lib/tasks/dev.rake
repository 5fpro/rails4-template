namespace :dev do

  desc "Rebuild from schema.rb"
  task build: ["tmp:clear", "log:clear", "db:drop", "db:create", "db:schema:load", "dev:fake"]

  desc "Rebuild from migrations"
  task rebuild: ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "dev:fake"]

  desc "generate fake data for development"
  task fake: :environment do
    email = "admin@5fpro.com"
    User.find_by(email: email) || FactoryGirl.create(:user, email: email, password: "12341234", admin: true)

    5.times do |i| 
    	site =	Site.create(name: "site#{i}", host: "host#{i}")
    	for j in 1..5 do
    		site.pages.create(title: "title#{j*5}", slug: "slug#{j*5}", body: "body#{j*5}")
    	end
    end
  end

end
