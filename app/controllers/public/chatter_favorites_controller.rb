class Public::ChatterFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chatter = Chatter.find(params[:chatter_id])
    @favorite = current_user.chatter_favorites.new(chatter_id: @chatter.id)
    @favorite.save
    @chatter.create_notification_favorite_chatter!(current_user)
    @chatter = Chatter.find(params[:chatter_id])
    # create.js.erbを参照する
  end

  def destroy
    @chatter = Chatter.find(params[:chatter_id])
    @favorite = current_user.chatter_favorites.find_by(chatter_id: @chatter.id)
    @favorite.destroy
    @chatter = Chatter.find(params[:chatter_id])
    # destroy.js.erbを参照する
  end
end
