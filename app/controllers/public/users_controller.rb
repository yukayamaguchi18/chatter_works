class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :introduction, :profile_image, :is_public)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_path, alert: "アクセス権限がありません"
      end
    end

end
