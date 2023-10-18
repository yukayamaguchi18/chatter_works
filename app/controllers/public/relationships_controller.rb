class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_deactivated_user, only: [:create, :destroy, :followings, :followers]

  # フォローするとき
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end

  # フォロー外すとき
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
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
        flash[:alert] = "退会済みユーザーのページです"
        redirect_to request.referer
      end
    end

end
