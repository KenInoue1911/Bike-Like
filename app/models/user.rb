class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name,    length: { in: 1..9 }
  validates :title,    length: { maximum: 100 }
  mount_uploader :avater, AvaterUploader
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :passive_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # 自分をフォローしている人
  has_many :followers, through: :passive_of_relationships, source: :follower
  # 自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォロー外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか
  def following?(user)
    followings.include?(user)
  end


  enum gender: {男性: 0, 女性: 1}
  # 退会しているユーザーがログインできないようにする
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
