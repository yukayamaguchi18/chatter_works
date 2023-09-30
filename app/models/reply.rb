class Reply < ApplicationRecord

  belongs_to :reply, class_name: "Chatter"
  belongs_to :reply_to, class_name: "Chatter"

end
