class Comment < ApplicationRecord

  validates :body, presence: true, length: {maximum: 400}

  belongs_to :work
  belongs_to :user

end
