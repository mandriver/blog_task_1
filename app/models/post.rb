class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy
  validates :title, :content, presence: true
  scope :by_rating, lambda { |top = 5|
    data = joins(:ratings).select(
      'posts.id, posts.title as title, posts.content as content,
      avg(ratings.value) as average_rating'
    ).group('posts.id').order('average_rating DESC').limit(top)
    data.map { |d| [d.title, d.content, d.average_rating.to_f] }
  }
  scope :repeatedly_ip, -> {
    joins(:user).select(
      'posts.ip as ip, array_agg(users.login) as login'
    ).group('ip').map { |i| (i.login = i.login.uniq) && i if i.login.uniq.length > 1 }.compact
  }
  def rating_average_value
    ratings.average(:value).to_f
  end
end
