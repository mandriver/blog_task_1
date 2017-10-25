class User < ApplicationRecord
  has_many :posts

  # Create user if he not exists, and return user id
  def self.create_if_not_exists(login)
    user = find_by(login: login)
    return user.id if user
    user = create(login: login)
    user.id
  end
end
