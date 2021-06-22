class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, { length: { in: 1..100 } }
end
