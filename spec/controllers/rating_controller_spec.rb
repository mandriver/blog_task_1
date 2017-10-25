require 'rails_helper'

RSpec.describe RatingController, type: :controller do
  VALID_RATING = 1
  INVALID_RATING = 6
  describe 'POST set' do
    context 'when valid data' do
      let(:user) { FactoryBot.create(:user) }
      let(:data) do
        post_id = FactoryBot.create(:post, user: user).id
        { rating: { value: VALID_RATING, post_id: post_id }, at: :json }
      end
      it 'Create rating for post' do
        post :set, params: data
      end
      it 'create new record in the database' do
        expect{
          post :set, params: data
        }.to change(Rating, :count).by(1)
      end
    end
    context 'when invalid data' do
      let(:user) { FactoryBot.create(:user) }
      let(:data) do
        post_id = FactoryBot.create(:post, user: user).id
        { rating: { value: INVALID_RATING, post_id: post_id }, at: :json }
      end
      it 'Create rating for post' do
        post :set, params: data
      end
      it 'create new record in the database' do
        expect{
          post :set, params: data
        }.to_not change(Rating, :count)
      end
    end
  end
end
