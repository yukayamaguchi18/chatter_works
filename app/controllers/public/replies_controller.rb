class Public::RepliesController < ApplicationController

  def create
    @chatter = Chatter.new(chatter_params)
    @chatter.user_id = current_user.id
      unless @chatter.save
        render 'error'  # error.js.erbを参照する
      end
    @reply = Reply.new(reply_params)
    @reply.reply_id =
      unless @reply.save
        render 'error'  # error.js.erbを参照する
      end

    @chatters = Chatter.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    flash.now[:notice] = "Replyを投稿しました"
    # create.js.erbを参照する

  end

  private

  def chatter_params
    params.require(:chatter).permit(:user_id, :body)
  end

  def reply_params
    params.require(:chatter).permit(reply:[:reply_id, :reply_to_id])
  end

end
