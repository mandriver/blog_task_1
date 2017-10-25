require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assign all users for @users' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end
end
