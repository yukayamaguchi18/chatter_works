class Public::WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_deactivated_user, only: [:show, :favorite_users]

  def show
    @work = Work.find(params[:id])
    @tags = @work.tags
    # タグ編集欄の初期値設定用に定義
    # @workについているタグのnameをpluckで配列にし、','で区切る
    @tag_list = @work.tags.pluck(:name).join(',')
    @comment = Comment.new
    @comments = @work.comments.includes([:user])
    @chatter = Chatter.new
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:work][:name].split(',')
    if @work.save
      @work.save_tag(tag_list)
      @works = Work.includes([:user]).with_attached_work_image.timeline(current_user).page(params[:page]).per(10)
      @host = request.protocol + request.host # create.js.erbで投稿したWorkのURL生成に使用
      flash.now[:notice] = "Workを投稿しました"
      # create.js.erbを参照する
    else
      render 'error' # error.js.erbを参照する
    end
  end

  def destroy
    @work = Work.find(params[:id])
    if @work.delete
      redirect_to user_path(current_user)
    end
  end

  def update
    @work = Work.find(params[:id])
    # タグの入力欄（workのname,本来workテーブルには存在しないカラム）の内容を','で区切ってタグのparamsとして取得
    tag_list = params[:work][:name].split(',')
    if @work.update(work_params)
      # もともとついていたタグを一度すべて削除
      @old_relations = WorkTag.where(work_id: @work.id)
      @old_relations.each do |relation|
        relation.delete
      end
      # work.rbのsave_tagメソッドで新たにタグを保存
      @work.save_tag(tag_list)
      @tags = @work.tags
      @tag_list = @work.tags.pluck(:name).join(',') # タグ編集欄の初期値設定用に定義
      flash.now[:notice] = 'Workを編集しました'
      # update.js.erbを参照する
    else
      render 'error'  # error.js.erbを参照する
    end
  end

  # タグのみ編集用action 使用保留 現行はworks#updateを流用
  # def update_tags
  #   @work = Work.find(params[:id])
  #   tag_list = params[:work][:name].split(',')
  #   if @work.update(work_params)
  #     @old_relations = WorkTag.where(work_id: @work.id)
  #     @old_relations.each do |relation|
  #       relation.delete
  #     end
  #     @work.save_tag(tag_list)
  #     @tags = @work.tags
  #     @tag_list = @work.tags.pluck(:name).join(',')
  #     flash.now[:notice] = 'Tagを編集しました'
  #     # update_tags.js.erbを参照する
  #   else
  #     render 'error'  # error.js.erbを参照する
  #   end
  # end

  def tl_update
    @works = Work.includes([:user]).with_attached_work_image.timeline(current_user).page(params[:page]).per(10)
  end

  def favorite_users
    @work = Work.find(params[:id])
  end

  def tag_link_search
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @works = @tag.works.includes([:user]).with_attached_work_image.order(created_at: :desc).page(params[:page]).per(10)
    @model = "WorkTag"
    @word = @tag.name
    return unless request.xhr?
    case params[:type]
    when 'chatter', 'work'
      render "public/#{params[:type]}s/page"
    end
  end

  private

    def work_params
      params.require(:work).permit(:title, :caption, :user_id, :work_image)
    end

    def ensure_deactivated_user
      @work = Work.find(params[:id])
      @user = @work.user
      unless @user.is_active == true
        flash[:alert] = "退会済みユーザーのページです"
        redirect_to request.referer
      end
    end

end
