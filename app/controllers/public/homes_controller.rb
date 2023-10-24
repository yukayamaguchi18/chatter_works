class Public::HomesController < ApplicationController
  before_action :before_login_redirect

  def top
    @user = User.find(current_user.id)
    @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
    # Work timeline用@works定義
    tags = current_user.tags
    tags.each_with_index do |tag, i|
      work_tags = WorkTag.where(tag_id: tag.id)
      if i == 0
        work_tags.each_with_index do |work_tag, j|
          @works = Work.where(id: work_tag.work_id) if j == 0
          @works = @works.or(Work.where(id: work_tag.work_id))
        end
      else
        work_tags.each do |work_tag|
          @works = @works.or(Work.where(id: work_tag.work_id))
        end
      end
    end
    unless @works.blank?
      @works = @works.includes([:user, user: { profile_image_attachment: :blob }]).with_attached_work_image.order(created_at: :desc).page(params[:page]).per(10)
    end
    # Work timeline用定義ここまで
    @tag_list = @user.tags.pluck(:name).join(',') # タグ編集欄の初期値設定用に定義
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
