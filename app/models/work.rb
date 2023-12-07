class Work < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :caption, presence: true, length: { maximum: 3000 }

  has_many_attached :work_images

  def get_work_image(width, height)
    if self.user.is_public = false
      # 投稿者が非公開アカウントの場合はimages/no_work_image.jpgを参照
      file_path = Rails.root.join("app/assets/images/no_work_image.jpg")
      work_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    work_image.variant(resize_to_limit: [width, height]).processed
  end

  belongs_to :user
  counter_culture :user

  has_many :work_favorites, dependent: :destroy
  has_many :work_tags, dependent: :destroy
  has_many :tags, through: :work_tags
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

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

  def favorited_by?(user)
    work_favorites.exists?(user_id: user.id)
  end

  def self.search(word)
    # あいまい検索
    #   "?"に対してwordが順番に入る
    #   LIKEは、あいまい検索の意味で、"%"は、前後のあいまいという意味
    #   "#{word}"は、Rubyの式展開
    where("title LIKE ? OR caption LIKE ?", "%#{word}%", "%#{word}%")
  end

  # workへのお気に入り通知機能
  def create_notification_favorite_work!(current_user)
    # 同じユーザーが同じ投稿に既にお気に入りしていないかを確認
    existing_notification = Notification.find_by(work_id: self.id, visitor_id: current_user.id, action: "favorite_work")

    # すでにお気に入りされていない かつ お気に入りしたのが自分ではない場合のみ通知レコードを作成
    if existing_notification.nil? && current_user != self.user
      notification = Notification.new(
        work_id: self.id,
        visitor_id: current_user.id,
        visited_id: self.user.id,
        action: "favorite_work"
      )

      if notification.valid?
        notification.save
      end
    end
  end
end
