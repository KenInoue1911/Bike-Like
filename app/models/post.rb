class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  # タグ付け
  acts_as_taggable
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, {length: {in: 1..15} }
  validates :post_profile, {length: {in: 1..200} }
  validates :post_bike, {length: {in: 1..8} }
  validates :image, presence: true
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
