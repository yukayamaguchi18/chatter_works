class Reply < ApplicationRecord

  belongs_to :reply, class_name: "Chatter"
  belongs_to :reply_to, class_name: "Chatter"
  has_many :notifications, dependent: :destroy
  counter_culture :reply_to, column_name: "reply_to_chatters_count"

 # リプライ通知を作成するメソッド
 def save_notification_comment!(current_user, reply_id, visited_id)
   notification = current_user.active_notifications.build(
     chatter_id: self.reply_id,
     reply_id: self.id,
     visited_id: self.reply_to.user_id,
     action: 'reply'
   )

   # 自分の投稿に対するリプライの場合は、通知済みとする
   notification.is_checked = true if notification.visitor_id == notification.visited_id

   # 通知を保存（バリデーションが成功する場合のみ）
   notification.save if notification.valid?
 end


end
