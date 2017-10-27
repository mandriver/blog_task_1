require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:ratings) }
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
  describe 'scope' do
    let(:p1) { FactoryBot.create(:post, user: FactoryBot.create(:user)) }
    let(:p2) { FactoryBot.create(:post, user: FactoryBot.create(:user)) }
    it 'does sorting by rating' do
      FactoryBot.create(:rating, value: 1, post: p1)
      FactoryBot.create(:rating, value: 4, post: p1)
      FactoryBot.create(:rating, value: 3, post: p2)
      FactoryBot.create(:rating, value: 5, post: p2)
      first = [p2.title, p2.content, p2.rating_average_value]
      last = [p1.title, p1.content, p1.rating_average_value]
      expect(Post.by_rating).to eq([first, last])
    end
    it 'return repeatedly ip' do
      FactoryBot.create(:post, user: FactoryBot.create(:user, login: 'first_user'), ip: '10.0.0.1')
      FactoryBot.create(:post, user: FactoryBot.create(:user, login: 'last_user'), ip: '10.0.0.1')
      FactoryBot.create(:post, user: FactoryBot.create(:user), ip: '10.168.0.3')
      FactoryBot.create(:post, user: FactoryBot.create(:user), ip: '10.168.0.4')
      FactoryBot.create_list(:post, 2, user: FactoryBot.create(:user), ip: '10.0.0.5')
      expect(Post.repeatedly_ip.last.login).to match_array(['first_user', 'last_user'])
    end
  end
end
