class FollowRequest < ApplicationRecord

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  counter_culture :receiver, column_name: "receiving_requests_count"

  validates :sender_id, presence: true
  validates :receiver_id, presence: true

end
