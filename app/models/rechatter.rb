class Rechatter < ApplicationRecord
  belongs_to :user
  belongs_to :chatter
  counter_culture :chatter
  validates_uniqueness_of :chatter_id, scope: :user_id
end
