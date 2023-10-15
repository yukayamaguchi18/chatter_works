class ChatterFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :chatter
  has_one :chatter_user, through: :chatter, source: :user
  validates_uniqueness_of :chatter_id, scope: :user_id

end
