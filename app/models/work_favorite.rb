class WorkFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :work
  counter_culture :user
  counter_culture :work
  has_one :work_user, through: :work, source: :user
  validates_uniqueness_of :work_id, scope: :user_id

end
