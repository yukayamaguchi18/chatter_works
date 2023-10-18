class Public::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
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
      flash.now[:notice] = 'Follow Tagsを編集しました'
      # update.js.erbを参照する
    else
      render 'error'  # error.js.erbを参照する
    end
  end


end
