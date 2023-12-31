class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: true, length: { maximum: 500 }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      # プロフィール画像がない場合はimages/no_profile_image.jpgを参照
      file_path = Rails.root.join("app/assets/images/no_profile_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  has_many :chatters, dependent: :destroy
  has_many :chatter_favorites, dependent: :destroy
  has_many :rechatters, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :work_favorites, dependent: :destroy
  has_many :follow_tags, dependent: :destroy
  has_many :tags, through: :follow_tags

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローリクエストする側の関係性
  has_many :requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  # 自分がフォローリクエストされ側の関係性
  has_many :reverse_of_requests, class_name: "FollowRequest", foreign_key: "receiver_id", dependent: :destroy

  # 自分がフォローリクエストしている人
  has_many :sending_requests, through: :requests, source: :receiver
  # 自分にフォローリクエストしている人
  has_many :receiving_requests, through: :reverse_of_requests, source: :sender

  # 自分が通知を送る側の関係性
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  # 自分が通知を受け取る側の関係性
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # ゲストログイン用メールアドレス
  GUEST_USER_EMAIL = "guest@example.com"

  # ゲストログイン用メソッド
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.introduction = "guestuser"
      user.is_public = true
      user.is_active = true
    end
  end

  # ゲストログインユーザー判別
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # ユーザーをフォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # ユーザーをアンフォローする
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを確認する
  def following?(user)
    followings.include?(user)
  end

  # フォローされているか判定
  def followed?(user)
    followers.include?(user)
  end

  # フォローリクエストを送っているかを確認する
  def follow_requested?(user)
    self.sending_requests.include?(user)
  end

  def rechattered?(chatter_id)
    self.rechatters.where(chatter_id: chatter_id).exists?
  end

  # users#show ユーザーのchatterとrechatter取得メソッド
  def chatters_with_rechatters
    relation = Chatter.joins("LEFT OUTER JOIN rechatters ON chatters.id = rechatters.chatter_id AND rechatters.user_id = #{self.id}")
                   .select("chatters.*, rechatters.user_id AS rechatter_user_id, (SELECT name FROM users WHERE id = rechatters.user_id) AS rechatter_user_name")
    relation.where(user_id: self.id)
            .or(relation.where("rechatters.user_id = ?", self.id))
            .includes(:user, :reply_to_chatters)
            .order(Arel.sql("CASE WHEN rechatters.created_at IS NULL THEN chatters.created_at ELSE rechatters.created_at END DESC"))
  end

  # homes#top TLのchatterとrechatter取得メソッド内で利用するメソッド
  def followings_with_userself
    User.where(id: self.followings.pluck(:id)).or(User.where(id: self.id))
  end

  # homes#top TLのchatterとrechatter取得メソッド
  def followings_chatters_with_rechatters
    relation = Chatter.joins("LEFT OUTER JOIN rechatters ON chatters.id = rechatters.chatter_id AND (rechatters.user_id = #{self.id} OR rechatters.user_id IN (SELECT followed_id FROM relationships WHERE follower_id = #{self.id}))")
                   .select("chatters.*, rechatters.user_id AS rechatter_user_id, (SELECT name FROM users WHERE id = rechatters.user_id) AS rechatter_user_name")
    relation.where(user_id: self.followings_with_userself.pluck(:id))
            .or(relation.where(id: Rechatter.where(user_id: self.followings_with_userself.pluck(:id)).distinct.pluck(:chatter_id)))
            .where("NOT EXISTS(SELECT 1 FROM rechatters sub WHERE rechatters.chatter_id = sub.chatter_id AND rechatters.created_at < sub.created_at)")
            .includes([:user, :reply_to_chatters, user: { profile_image_attachment: :blob } ])
            .order(Arel.sql("CASE WHEN rechatters.created_at IS NULL THEN chatters.created_at ELSE rechatters.created_at END DESC"))
  end

  # お気に入りタグ登録用メソッド follow_tags#follow_tagsで使用
  # selfにcurrent_userを指定
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.destroy　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
     new_work_tag = Tag.find_or_create_by(name: new.strip) # stripで空白削除
     self.tags << new_work_tag # タグの配列に新たなタグを追加
   end
  end

  # フォロー通知を作成するメソッド
  def create_notification_follow!(current_user)
    # すでにフォロー通知が存在するか検索

    existing_notification = Notification.find_by(visitor_id: current_user.id, visited_id: self.id, action: "follow")

    # フォロー通知が存在しない場合のみ、通知レコードを作成
    if existing_notification.blank?
      notification = current_user.active_notifications.build(
        visited_id: self.id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

  # フォローリクエスト受信通知を作成するメソッド
  def create_notification_receive_follow_request!(current_user)
    # すでにフォローリクエスト受信通知が存在するか検索

    existing_notification = Notification.find_by(visitor_id: current_user.id, visited_id: self.id, action: "receive_follow_request")

    # フォローリクエスト受信通知が存在しない場合のみ、通知レコードを作成
    if existing_notification.blank?
      notification = current_user.active_notifications.build(
        visited_id: self.id,
        action: "receive_follow_request"
      )
      notification.save if notification.valid?
    end
  end

  # フォローリクエスト承認通知を作成するメソッド
  def create_notification_allow_follow_request!(current_user)
    # すでにフォローリクエスト承認通知が存在するか検索

    existing_notification = Notification.find_by(visitor_id: current_user.id, visited_id: self.id, action: "allow_follow_request")

    # フォローリクエスト承認通知が存在しない場合のみ、通知レコードを作成
    if existing_notification.blank?
      notification = current_user.active_notifications.build(
        visited_id: self.id,
        action: "allow_follow_request"
      )
      notification.save if notification.valid?
    end
  end

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_active == true)
  end

  def self.search(word)
    # あいまい検索
    #   "?"に対してwordが順番に入る
    #   LIKEは、あいまい検索の意味で、"%"は、前後のあいまいという意味
    #   "#{word}"は、Rubyの式展開
    where("name LIKE ? OR introduction LIKE ?", "%#{word}%", "%#{word}%")
  end
end
