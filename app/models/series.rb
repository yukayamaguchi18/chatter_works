class Series < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  belongs_to :user
  has_many :works

end
