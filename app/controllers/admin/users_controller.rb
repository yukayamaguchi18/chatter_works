class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @chatters = @user.chatters_with_rechatters.page(params[:page]).per(20)
    @works = @user.works.with_attached_work_image.order(created_at: :desc).page(params[:page]).per(10)
    @chatter_favorites = @user.chatter_favorites.includes([:chatter, :chatter_user]).order(created_at: :desc).page(params[:page]).per(20)
    @work_favorites = @user.work_favorites.includes([:work, :work_image, :work_user]).order(created_at: :desc).page(params[:page]).per(10)
    return unless request.xhr?
    case params[:type]
    when 'chatter', 'work', 'chatter_favorite', 'work_favorite'
      render "admin/users/#{params[:type]}_page"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "変更しました"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :introduction, :profile_image, :is_public, :is_active)
    end

end
