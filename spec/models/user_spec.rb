require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
  end
  describe 'create if not exists method' do
    context 'when user not exists' do
      it 'create new user in the database' do
        expect{
          User.create_if_not_exists('NewUser')
        }.to change(User, :count).by(1)
      end
    end
    context 'when user exists' do
      it 'not create user in the database' do
        user = FactoryBot.create(:user)
        expect{
          User.create_if_not_exists(user.login)
        }.to change(User, :count).by(0)
      end
    end
  end
end
