class Reply < ApplicationRecord

  belongs_to :reply, class_name: "Chatter"
  belongs_to :reply_to, class_name: "Chatter"
  counter_culture :reply_to, column_name: "reply_to_chatters_count"

end
