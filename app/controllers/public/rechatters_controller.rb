class Public::RechattersController < ApplicationController
  before_action :set_chatter

  def create  # メガホンボタンを押下すると、押したユーザと押した投稿のIDよりrechattersテーブルに登録する
    if Rechatter.find_by(user_id: current_user.id, chatter_id: @chatter.id)
      redirect_to request.referer, alert: '既にRechatter済みです'
    else
      @rechatter = Rechatter.create(user_id: current_user.id, chatter_id: @chatter.id)
    end
    flash.now[:notice] = "Rechatterしました"
    # create.js.erbを参照する
  end

  def destroy  # 既にrechatterした投稿のメガホンボタンを再度押下すると、rechatterを取り消す（=テーブルからデータを削除する）
    @rechatter = current_user.rechatters.find_by(chatter_id: @chatter.id)
    if @rechatter.present?
      @rechatter.destroy
    else
      redirect_to request.referer, alert: '既にRechatterを取り消し済みです'
    end
    flash.now[:notice] = "Rechatterを取り消しました"
    # destroy.js.erbを参照する
  end

  private
  def set_chatter  # メガホンボタンを押した投稿を特定する
    @chatter = Chatter.find(params[:chatter_id])
    if @chatter.nil?
      redirect_to request.referer, alert: '該当の投稿が見つかりません'
    end
  end

end
