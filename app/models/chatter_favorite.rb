class ChatterFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :chatter

end
