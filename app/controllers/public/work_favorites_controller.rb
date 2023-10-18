class Public::WorkFavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @work = Work.find(params[:work_id])
    @favorite = current_user.work_favorites.new(work_id: @work.id)
    @favorite.save
  end

  def destroy
    @work = Work.find(params[:work_id])
    @favorite = current_user.work_favorites.find_by(work_id: @work.id)
    @favorite.destroy
  end

end
