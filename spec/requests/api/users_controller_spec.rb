require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  let!(:user) { create(:user) }

  it '#index' do
    get 'http://api.localhost/users.json', api_params(abc: 1)
    expect(response.status).to eq(200)
    expect(response.body).to include(user.email)
    expect(parse_response.first["id"]).to eq(user.id)
  end

  it '#create' do
    post 'http://api.localhost/users.json', api_params(user: { email: 'mars@5fpro.com', password: '12341234' })
    expect(response.status).to eq(200)
    expect(parse_response['user']['id']).to eq(User.last.id)
  end
end
