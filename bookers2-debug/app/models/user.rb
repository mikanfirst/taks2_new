class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  # has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy　#フォロー与えるが側の記述
  # has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy　#フォローされる側の記述
  # has_many :following_user, through: :follower, source: :followed　#フォロー与えるが側の記述
  # has_many :follower_user, through: :followed, source: :follower　#フォローされる側の記述
  #ユーザーをフォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #ユーザーもフォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしていればtrueを返す
  def following?(user)
    followings.include?(user)
  end

end
