class Work < ApplicationRecord

  validates :title, presence: true, length: {maximum: 50}
  validates :caption, presence: true, length: {maximum: 3000}

  has_one_attached :work_image

  def get_work_image(width, height)
    unless work_image.attached?
      # 商品画像がない場合はimages/no-image.jpgを参照
      file_path = Rails.root.join('app/assets/images/no_work_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    work_image.variant(resize_to_limit: [width, height]).processed
  end

  belongs_to :user

  has_many :work_favorites
  has_many :work_tags, dependent: :destroy
  has_many :tags, through: :work_tags
  has_many :comments

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - sent_tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = sent_tags - current_tags

      # 古いタグを消す
      old_tags.each do |old|
        self.tags.delete　Tag.find_by(name: old)
      end

      # 新しいタグを保存
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new.strip) # stripで空白削除
        self.tags << new_post_tag # タグの配列に新たなタグを追加
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
    where('title LIKE ? OR caption LIKE ?', "%#{word}%", "%#{word}%")
  end

end
