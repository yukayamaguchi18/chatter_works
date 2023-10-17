class Public::FollowRequestsController < ApplicationController

  # フォローリクエストを送る
  def create
    @user = User.find(params[:user_id])
    @request = FollowRequest.new(receiver_id: @user.id, sender_id: current_user.id)
    @request.save
    flash.now[:notice] = "フォローリクエストを送りました"
    # create.js.erbを参照する
  end

  # 自分が送ったフォローリクエストを取り下げる
  def destroy
    @user = User.find(params[:user_id])
    @request = FollowRequest.find_by(receiver_id: @user.id, sender_id: current_user.id)
    @request.destroy
    flash.now[:notice] = "フォローリクエストを取り下げました"
    # destroy.js.erbを参照する
  end

  def index
    @requests = FollowRequest.where(receiver_id: current_user.id)
    #ログイン中のユーザーが受け取ったフォローリクエストを全て取得
  end

  # フォローリクエストを承認する
  def allow
    @request = FollowRequest.find(params[:id])
    @user = User.find_by(id: @request.sender_id)
    @follow = Relationship.new(followed_id: current_user.id, follower_id: @request.sender_id)
      #follow_requestsコントローラーですが、relationshipsのnewメソッドです。
    @follow.save # relationshipに保存。
    @request.destroy # follow_requestは削除
    @requests = FollowRequest.where(receiver_id: current_user.id)
    flash.now[:notice] = "フォローリクエストを承認しました"
    # allow.js.erbを参照する
  end

  # フォローリクエストを拒否する
  def reject
    request = FollowRequest.find(params[:id])
    request.destroy
    @requests = FollowRequest.where(receiver_id: current_user.id)
    flash.now[:notice] = "フォローリクエストを拒否しました"
    # reject.js.erbを参照する
  end

end
