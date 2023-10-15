class Public::HomesController < ApplicationController
  before_action :before_login_redirect

  def top
    @user = User.find(current_user.id)
    @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
    @works = Work.includes([:user]).with_attached_work_image.timeline(current_user).page(params[:page]).per(10)
    @chatter = Chatter.new
    @work = Work.new
    @reply = Reply.new
    return unless request.xhr?
    case params[:type]
    when 'chatter', 'work'
      render "public/#{params[:type]}s/page"
    end
  end

  private

  def before_login_redirect
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "アクセス権限がありません。ログインしてください。"
    end
  end

end
