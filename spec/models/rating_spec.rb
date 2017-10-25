require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should validate_inclusion_of(:value).in_range(1..5) }
  end
  describe 'rating average value' do
    it 'does calculates the average value' do
      post = FactoryBot.create(:post, user: FactoryBot.create(:user))
      VALUE1 = 1
      VALUE2 = 4
      FactoryBot.create(:rating, value: VALUE1, post: post)
      FactoryBot.create(:rating, value: VALUE2, post: post)
      AVERAGE_VALUE = (VALUE1.to_f + VALUE2) / 2
      expect(post.rating_average_value).to eq(AVERAGE_VALUE)
    end
  end
end
