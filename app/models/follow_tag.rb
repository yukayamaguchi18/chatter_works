class FollowTag < ApplicationRecord
  validates :user_id, presence: true
  validates :tag_id, presence: true
  belongs_to :user
  belongs_to :tag
  validates_uniqueness_of :tag_id, scope: :user_id
end
