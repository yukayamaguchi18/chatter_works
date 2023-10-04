class Public::ChattersController < ApplicationController
  def show
    @chatter = Chatter.find(params[:id])
  end

  def new
    @chatter = Chatter.new
    @chatter.user_id = current_user.id
  end

  def create
    @chatter = Chatter.new(chatter_params)
    @chatter.user_id = current_user.id
      unless @chatter.save
        render 'error'  # error.js.erbを参照する
      end
    @chatters = Chatter.where(user_id: [current_user.id, *current_user.followings])
    flash.now[:notice] = "Chatterを投稿しました"
    # create.js.erbを参照する
  end

  private

  def chatter_params
    params.require(:chatter).permit(:user_id, :body)
  end

end
