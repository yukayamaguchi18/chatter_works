class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @work = Work.find(params[:work_id])
    @comment = Comment.new(comment_params)
    @comment.work_id = @work.id
    @comment.user_id = current_user.id
    unless @comment.save
      render 'error'  # error.js.erbを参照する
    end
    @comment.save_notification_comment!(current_user)
    @comments = @work.comments.includes([:user])
    @host = request.protocol + request.host # create.js.erbで投稿したWorkのURL生成に使用
    flash.now[:notice] = "Commentを投稿しました"
    # create.js.erbを参照する
  end

  def destroy
    @work = Work.find(params[:work_id])
    comment = Comment.find_by(id: params[:id], work_id: params[:work_id])
    comment.destroy
    @comments = @work.comments.includes([:user])
    flash.now[:notice] = "Commentを削除しました"
    # destroy.js.erbを参照する
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :work_id, :user_id)
  end

end
