class Public::WorkFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @work = Work.find(params[:work_id])
    @favorite = current_user.work_favorites.new(work_id: @work.id)
    @favorite.save
    @work.create_notification_favorite_work!(current_user)
    @work = Work.find(params[:work_id])
    # create.js.erbを参照する
  end

  def destroy
    @work = Work.find(params[:work_id])
    @favorite = current_user.work_favorites.find_by(work_id: @work.id)
    @favorite.destroy
    @work = Work.find(params[:work_id])
    # destroy.js.erbを参照する
  end

end
