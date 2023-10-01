class Chatter < ApplicationRecord

  validates :body, presence: true, length: {maximum: 200}

  belongs_to :user

  has_many :chatter_favorites
  has_many :rechatters

  has_many :replying, class_name: 'Reply', foreign_key: 'chatter_id', dependent: :destroy
  has_many :replying_to, class_name: 'Reply', foreign_key: 'reply_to_id', dependent: :destroy
  has_many :reply_chatter, through: :replying, source: :reply
  has_many :reply_to_chatter, through: :replying_to, source: :reply_to

end
