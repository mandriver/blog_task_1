class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings
  validates :title, :content, presence: true
  
  def rating_average_value
    ratings.average(:value).to_f
  end

  def top(n)

  end
end
