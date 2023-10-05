class WorkTag < ApplicationRecord

  validates :work_id, presence: true
  validates :tag_id, presence: true
  belongs_to :tag
  belongs_to :work

end
