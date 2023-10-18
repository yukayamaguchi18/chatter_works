class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_correct_user, only: [:edit, :update, :confirm, :withdraw]
  before_action :ensure_guest_user, only: [:edit, :update, :confirm, :withdraw]

  def show
    @user = User.find(params[:id])
    @chatters = @user.chatters_with_rechatters.page(params[:page]).per(20)
    @works = @user.works.with_attached_work_image.order(created_at: :desc).page(params[:page]).per(10)
    @chatter_favorites = @user.chatter_favorites.includes([:chatter, :chatter_user, :chatter_reply_to_chatters]).order(created_at: :desc).page(params[:page]).per(20)
    @work_favorites = @user.work_favorites.includes([:work, :work_image, :work_user]).order(created_at: :desc).page(params[:page]).per(10)
    return unless request.xhr?
    case params[:type]
    when 'chatter', 'work', 'chatter_favorite', 'work_favorite'
      render "public/#{params[:type]}s/page"
    end
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

  def set_user
    @user = User.find(params[:id])
  end

end
