class Comment < ApplicationRecord

  validates :body, presence: true, length: {maximum: 400}

  belongs_to :work
  belongs_to :user
  has_many :notifications, dependent: :destroy
  counter_culture :work

 # コメント通知を作成するメソッド
 def save_notification_comment!(current_user)
   notification = current_user.active_notifications.build(
     work_id: self.work_id,
     comment_id: self.id,
     visited_id: self.work.user_id,
     action: 'comment'
   )

   # 自分の投稿に対するコメントの場合は、通知済みとする
   notification.is_checked = true if notification.visitor_id == notification.visited_id

   # 通知を保存（バリデーションが成功する場合のみ）
   notification.save if notification.valid?
 end

end
