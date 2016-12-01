require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  let!(:user) { User.create!(email: 'xxx@example.com', password: '12341234') }

  before do
    # respond_error unless request.headers.to_h["HTTP_X_TOKEN"] == "123456"
    request.headers['HTTP_X_TOKEN'] = '123456'
  end

  it '#index' do

    get :index, params: { abc: 1 }
    expect(response.status).to eq(200)
  end

  describe '#create' do

    it 'success case' do
      expect {
        post :create, params: { user: { email: 'mars@5fpro.com', password: '12341234' } }
      }.to change { User.count }.by(1)
      expect(response.status).to eq(200)
    end

    describe 'fail cases' do

      it 'invalid email format' do
        expect {
          post :create, params: { user: { email: '@', password: '12341234' } }
        }.not_to change { User.count }
        expect(response.status).to eq(400)
      end

      it 'email blank' do
        expect {
          post :create, params: { user: { email: '', password: '12341234' } }
        }.not_to change { User.count }
        expect(response.status).to eq(400)
      end

      it 'duplicated email' do
        expect {
          post :create, params: { user: { email: user.email, password: '12341234' } }
        }.not_to change { User.count }
        expect(response.status).to eq(400)
      end

      it 'password too short' do
        expect {
          post :create, params: { user: { email: 'mars@5fpro.com', password: '1234' } }
        }.not_to change { User.count }
        expect(response.status).to eq(400)
      end
    end
  end
end
