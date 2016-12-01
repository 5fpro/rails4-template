# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'FactoryGirl' do
    it 'create' do
      user = create :user
      expect(user).to be_a(User)
      expect(user.id).to be_present
    end

    it 'build' do
      user = build :user # User.new
      expect(user).to be_a(User)
      expect(user.id).to eq(nil)
    end

    it 'attributes_for' do
      user = attributes_for :user
      expect(user).to be_a(Hash)
    end

    it 'overwrite' do
      user = create :user, email: 'xxxxxxxxxx@gmail.com', name: 'Mary'
      expect(user.email).to eq('xxxxxxxxxx@gmail.com')
      expect(user.name).to eq('Mary')
      # build, attributes_for same way
    end

    it 'sequence' do
      puts create(:user).email
      puts build(:user).email
      puts attributes_for(:user)[:email]
      puts create(:user).email
    end

    it 'trait :invalid' do
      user = build(:user, :invalid_email, :invalid_password, name: 'Mars')
      expect(user.save).to eq(false)
    end
  end
end
