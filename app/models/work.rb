class Work < ApplicationRecord

  validates :title, presence: true, length: {maximum: 50}
  validates :caption, presence: true, length: {maximum: 3000}

  belongs_to :user

  has_many :work_favorites
  has_many :work_tags
  has_many :comments

end
