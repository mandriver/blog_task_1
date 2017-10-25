class Rating < ApplicationRecord
  belongs_to :post
  validates :value, inclusion: 1..5
end
