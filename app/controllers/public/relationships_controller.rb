class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_deactivated_user, only: [:create, :destroy, :followings, :followers]

  # フォローするとき
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
    @user = User.find(params[:user_id])
    # create.js.erbを参照する
  end

  # フォロー外すとき
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    # destroy.js.erbを参照する
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.with_attached_profile_image
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.with_attached_profile_image
  end

  private
    def ensure_deactivated_user
      @user = User.find(params[:user_id])
      unless @user.is_active == true
        flash[:alert] = "退会済みのユーザーです"
        redirect_to error_path
      end
    end
end
