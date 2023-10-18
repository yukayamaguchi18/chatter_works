class ChatterFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :chatter
  counter_culture :user
  counter_culture :chatter
  has_one :chatter_user, through: :chatter, source: :user
  has_one :chatter_reply_to_chatters, through: :chatter, source: :reply_to_chatters
  validates_uniqueness_of :chatter_id, scope: :user_id

end
