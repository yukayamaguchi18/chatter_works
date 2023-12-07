class WorkTag < ApplicationRecord
  validates :work_id, presence: true
  validates :tag_id, presence: true
  belongs_to :tag
  belongs_to :work
  counter_culture :tag
  validates_uniqueness_of :tag_id, scope: :work_id
end
