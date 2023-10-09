class Chatter < ApplicationRecord

  validates :body, presence: true, length: {maximum: 200}

  belongs_to :user

  has_many :chatter_favorites, dependent: :destroy
  has_many :rechatters, dependent: :destroy

  has_many :replying, class_name: 'Reply', foreign_key: 'chatter_id', dependent: :destroy
  has_many :replying_to, class_name: 'Reply', foreign_key: 'reply_to_id', dependent: :destroy
  has_many :reply_chatter, through: :replying, source: :reply
  has_many :reply_to_chatter, through: :replying_to, source: :reply_to

  def favorited_by?(user)
    chatter_favorites.exists?(user_id: user.id)
  end

  # homes#top TL用メソッド ログインユーザーとそのフォロワーの投稿のみに絞り込み
  # model内ではcurrent_userメソッドが使えないため、
  # controller内でcurrent_userを引数に渡してメソッドを使う
  def self.timeline(user)
    where(user_id: [user.id, *user.followings]).order(created_at: :desc)
  end

  def self.search(word)
    # あいまい検索
    #   "?"に対してwordが順番に入る
    #   LIKEは、あいまい検索の意味で、"%"は、前後のあいまいという意味
    #   "#{word}"は、Rubyの式展開
    where('body LIKE ?', "%#{word}%")
  end

  # 検索結果用メソッド 公開アカウントおよびログインユーザーとそのフォローユーザーの投稿のみに絞り込み
  # model内ではcurrent_userメソッドが使えないため、
  # controller内でcurrent_userを引数に渡してメソッドを使う
  def self.search_range(user)
    self.where(user_id: [user.id, *user.followings]).or(self.where(users: User.where(is_public: true)))
  end

end
