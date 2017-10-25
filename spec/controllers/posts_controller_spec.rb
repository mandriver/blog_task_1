require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
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
