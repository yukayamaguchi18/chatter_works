class WorkTag < ApplicationRecord

  validates :name, presence: true, length: {maximum: 30}

  belongs_to :user
  belongs_to :work

end
