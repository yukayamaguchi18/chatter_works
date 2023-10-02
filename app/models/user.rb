class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  validates :introduction, presence: true, length: {maximum: 500}

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      # 商品画像がない場合はimages/no-image.jpgを参照
      file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  has_many :chatters
  has_many :chatter_favorites
  has_many :rechatters
  has_many :works
  has_many :work_favorites
  has_many :work_tags

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーをアンフォローする
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを確認する
  def following?(user)
    following_user.include?(user)
  end

end
