class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @notices = current_user.passive_notifications.includes(:visitor, :visited, :chatter, :work, :comment, visitor: { profile_image_attachment: :blob }).order(created_at: :desc)
    @unchecked_notifications = @notices.where(is_checked: false)

    # 確認済みの通知を取得
    @checked_notifications = @notices.where(is_checked: true).limit(20)

    # 通知を確認済みに更新
    current_user.passive_notifications.update_all(is_checked: true)
    render partial: "index"
  end

  def update_checked
    current_user.passive_notifications.update_all(is_checked: true)
    head :no_content # HTTPステータスコード204を返す（新しいページやデータが必要ない場合に使う）
  end

end
