FactoryGirl.define do
  factory :site do
    name 'www'
    host 'alphacamp'
    subdomain 'co'
  end
end

# FactoryGirl.define do
#   factory :user do
#     name '5Fpro'
#     sequence(:email) { |n| "user#{n}@5fpro.com" }
#     password '12341234'
#     confirmed_at Time.now

#     factory :admin_user do
#       admin true
#     end

#     factory :unconfirmed_user do
#       confirmed_at nil
#     end

#     factory :user_with_avatar do
#       avatar { File.open("#{Rails.root}/spec/fixtures/5fpro.png") }
#     end
#   end
# end
