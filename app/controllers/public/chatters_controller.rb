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
    @chatters = Chatter.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    flash.now[:notice] = "Chatterを投稿しました"
    # create.js.erbを参照する
  end

  def destroy
    @chatter = Chatter.find(params[:id])
    @chatter.delete
    @chatters = Chatter.timeline(current_user)
    flash.now[:notice] = "Chatterを削除しました"
    # destroy.js.erbを参照する
  end

  def reply
    # chatterを作成する
    @chatter = Chatter.new(chatter_params)
    @chatter.user_id = current_user.id
      unless @chatter.save
        render 'error'  # error.js.erbを参照する
      end
    # replyデータを作成する
    @reply = Reply.new(reply_params[:reply]) # reply_to_idをhidden fieldから受け取る
    @reply.reply_id = Chatter.last.id # 最新のchatter.idをreply_idに格納
      unless @reply.save
        render 'error'  # error.js.erbを参照する
      end
    @chatters = Chatter.timeline(current_user)
    flash.now[:notice] = "Replyを投稿しました"
    # reply.js.erbを参照する
  end

  def tl_update
    @user = User.find(current_user.id)
    @chatters = @user.followings_chatters_with_rechatters
  end

  def favorite_users
    @chatter = Chatter.find(params[:id])
  end

  def rechatter_users
    @chatter = Chatter.find(params[:id])
  end

  private

  def chatter_params
    params.require(:chatter).permit(:user_id, :body)
  end

  def reply_params
    params.require(:chatter).permit(reply:[:reply_id, :reply_to_id])
  end

end
