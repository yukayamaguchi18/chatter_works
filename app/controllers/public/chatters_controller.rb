class Public::ChattersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]
  before_action :ensure_deactivated_user, only: [:show, :favorite_users, :rechatter_users]

  def show
    @chatter = Chatter.includes([:user]).find(params[:id])
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
    @user = User.find(current_user.id)
    @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
    flash.now[:notice] = "Chatterを投稿しました"
    # create.js.erbを参照する
  end

  def destroy
    @chatter = Chatter.find(params[:id])
    @chatter.destroy
    path = Rails.application.routes.recognize_path(request.referer) # 条件分岐用 遷移元パスを取得
    if path[:controller] == "public/homes" && path[:action] == "top" # 遷移元コントローラ・アクションで分岐
      @user = User.find(current_user.id)
      @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
      flash.now[:notice] = "Chatterを削除しました"
      # destroy.js.erbを参照する
    elsif path[:controller] == "public/users" && path[:action] == "show"
      @user = User.find(path[:id]) # 遷移元URLのidを取得
      @chatters = @user.chatters_with_rechatters.page(params[:page]).per(20)
      flash.now[:notice] = "Chatterを削除しました"
      # destroy.js.erbを参照する
    else
      redirect_to request.referrer, notice: "Chatterを削除しました"
    end
  end

  def reply
    # chatterを作成する
    @chatter = Chatter.new(chatter_params)
    @chatter.user_id = current_user.id
      unless @chatter.save
        render 'error'  # error.js.erbを参照する
      else
      # replyデータを作成する
      @reply = Reply.new(reply_params[:reply]) # reply_to_idをhidden fieldから受け取る
      @reply.reply_id = Chatter.last.id # 最新のchatter.idをreply_idに格納
        unless @reply.save
          render 'error'  # error.js.erbを参照する
        else
          path = Rails.application.routes.recognize_path(request.referer) # 条件分岐用 遷移元パスを取得
          if path[:controller] == "public/homes" && path[:action] == "top" # 遷移元コントローラ・アクションで分岐
            @user = User.find(current_user.id)
            @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
            flash.now[:notice] = "Replyを投稿しました"
            # reply.js.erbを参照する
          elsif path[:controller] == "public/users" && path[:action] == "show"
            @user = User.find(path[:id]) # 遷移元URLのidを取得
            @chatters = @user.chatters_with_rechatters.page(params[:page]).per(20)
            flash.now[:notice] = "Replyを投稿しました"
            # reply.js.erbを参照する
          else
            redirect_to request.referrer, notice: "Replyを投稿しました"
          end
        end
      end
  end

  def tl_update
    @user = User.find(current_user.id)
    @chatters = @user.followings_chatters_with_rechatters.page(params[:page]).per(20)
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

    def ensure_correct_user
      @chatter = Chatter.find(params[:id])
      @user = @chatter.user
      unless @user == current_user
        flash[:alert] = "アクセス権限がありません"
        redirect_to error_path
      end
    end

    def ensure_deactivated_user
      @chatter = Chatter.find(params[:id])
      @user = @chatter.user
      unless @user.is_active == true
        flash[:alert] = "退会済みユーザーの投稿です"
        redirect_to error_path
      end
    end

end
