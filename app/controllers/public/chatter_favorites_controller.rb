class Public::ChatterFavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @chatter = Chatter.find(params[:chatter_id])
    @favorite = current_user.chatter_favorites.new(chatter_id: @chatter.id)
    @favorite.save
  end

  def destroy
    @chatter = Chatter.find(params[:chatter_id])
    @favorite = current_user.chatter_favorites.find_by(chatter_id: @chatter.id)
    @favorite.destroy
  end

end
