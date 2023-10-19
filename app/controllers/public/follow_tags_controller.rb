class Public::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def follow_tags
    @user = User.find(current_user.id)
    # タグの入力欄（userのtag_name,本来userテーブルには存在しないカラム）の内容を','で区切ってタグのparamsとして取得
    tag_list = params[:user][:tag_name].split(',')
    if @user.update(user_params)
      # もともとついていたタグを一度すべて削除
      @old_relations = FollowTag.where(user_id: @user.id)
      @old_relations.each do |relation|
        relation.delete
      end
      # user.rbのsave_tagメソッドで新たにタグを保存
      @user.save_tag(tag_list)
      @tags = @user.tags
      @tag_list = @user.tags.pluck(:name).join(',') # タグ編集欄の初期値設定用に定義

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
        @works = @works.includes([:user]).with_attached_work_image.order(created_at: :desc).page(params[:page]).per(10)
      end
      return unless request.xhr?
      case params[:type]
      when 'chatter', 'work'
        render "public/#{params[:type]}s/page"
      end
      # Work timeline用定義ここまで

      flash.now[:notice] = 'Follow Tagsを編集しました'
      # follow_tags.js.erbを参照する
    else
      render 'error'  # error.js.erbを参照する
    end
  end

  private
    def user_params
      params.require(:user).permit()
    end


end
