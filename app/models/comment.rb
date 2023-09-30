class Comment < ApplicationRecord

  belongs_to :chatter
  belongs_to :work

end
