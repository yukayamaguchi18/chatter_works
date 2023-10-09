class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_correct_user, only: [:edit, :update, :confirm, :withdraw]
  before_action :ensure_guest_user, only: [:edit, :update, :confirm, :withdraw]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "変更しました"
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:alert] = "アカウント消去処理を実行しました"
    redirect_to new_user_session_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :introduction, :profile_image, :is_public)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:alert] = "アクセス権限がありません"
        redirect_to root_path
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.guest_user?
        redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end

end
