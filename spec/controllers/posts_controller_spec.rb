require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) do
    FactoryBot.create(
      :post, user: FactoryBot.create(:user), title: 'p1', content: 'b1'
    )
  end
  let(:post2) do
    FactoryBot.create(
      :post, user: FactoryBot.create(:user), title: 'p2', content: 'b2'
    )
  end

  describe 'GET repeatedly_ip_users' do
    it 'does render ' do
      FactoryBot.create(:post, user: FactoryBot.create(:user))
      FactoryBot.create(:post, user: FactoryBot.create(:user))
      get :repeatedly_ip_users
      expect(JSON.parse(response.body)['192.168.0.1'].length).to eq(2)
    end
  end
  describe 'GET top' do
    it 'does render top' do
      Rating.create(post: post1, value: 1)
      Rating.create(post: post1, value: 4)
      Rating.create(post: post2, value: 1)
      Rating.create(post: post2, value: 3)
      get :top, params: { id: 2 }
      expect(JSON.parse(response.body)).to eq(
        [['p1', 'b1', 2.5], ['p2', 'b2', 2.0]]
      )
      expect(response.status).to eq(200)
    end
  end
  context "when valid data" do
    describe 'POST create' do
      let(:json_data) do
        post_params = FactoryBot.attributes_for(:post, login: user.login)
        { at: :json, post: post_params }
      end

      it 'response json data with status 200' do
        post :create, params: json_data
        expect(JSON.parse(response.body)['title']).to eq(json_data[:post][:title])
        expect(response.status).to eq(200)
      end

      it 'create new post in the database' do
        expect {
          post :create, params: json_data
        }.to change(Post, :count).by(1)
      end
    end
  end
  context "when invalid data" do
    describe 'POST create' do
      let(:json_data) do
        post_params = FactoryBot.attributes_for(:post, title: '', login: user.login)
        { at: :json, post: post_params }
      end

      it 'response json data with status 422' do
        post :create, params: json_data
        expect(response.status).to eq(422)
      end

      it 'not create new post in the database' do
        expect {
          post :create, params: json_data
        }.to_not change(Post, :count)
      end
    end
  end
end
