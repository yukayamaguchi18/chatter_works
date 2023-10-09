class Public::HomesController < ApplicationController
  before_action :before_login_redirect

  def top
    @chatters = Chatter.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    @works = Work.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    @chatter = Chatter.new
    @work = Work.new
  end

  private

  def before_login_redirect
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "アクセス権限がありません。ログインしてください。"
    end
  end

end
