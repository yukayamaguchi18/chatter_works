class Public::SeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]
  before_action :destroyed?, only: [:show, :destroy, :favorite_users, :rechatter_users]
  before_action :ensure_deactivated_user, only: [:show, :favorite_users, :rechatter_users]
  
  def index
    @series = current_user.series.all
  end
  
  def show
    
  end

  def create
  end

  def update
  end

  def destroy
  end
  
  private
  
    def ensure_correct_user
      @series = Series.find(params[:id])
      @user = @series.user
      unless @user == current_user
        flash[:alert] = "アクセス権限がありません"
        redirect_to error_path
      end
    end

    def destroyed?
      unless @series = Series.find_by(id: params[:id])
        flash[:alert] = "存在しない・または削除されたシリーズです"
        redirect_to error_path
      end
    end

    def ensure_deactivated_user
      @series = Series.find(params[:id])
      @user = @series.user
      unless @user.is_active == true
        flash[:alert] = "退会済みユーザーのシリーズです"
        redirect_to error_path
      end
    end
  
end
