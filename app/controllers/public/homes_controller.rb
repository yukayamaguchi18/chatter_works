class Public::HomesController < ApplicationController
  before_action :before_login_redirect

  def top
    @chatters = Chatter.timeline(current_user)
    @works = Work.timeline(current_user)
    @chatter = Chatter.new
    @work = Work.new
    @reply = Reply.new
  end

  private

  def before_login_redirect
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "アクセス権限がありません。ログインしてください。"
    end
  end

end
