class WorkFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :work
  has_one :work_user, through: :work, source: :user
  has_one :work_image, through: :work, source: :work_image_attachment
  validates_uniqueness_of :work_id, scope: :user_id

end
