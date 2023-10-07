class ChatterFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :chatter
  validates_uniqueness_of :chatter_id, scope: :user_id

end
