class Public::WorksController < ApplicationController


  def new
  end

  def show
    @work = Work.find(params[:id])
    @tags = @work.tags
    @tag_list = @work.tags.pluck(:name).join(',')
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:work][:name].split(',')
    if @work.save
      @work.save_tag(tag_list)
      @works = Work.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
      @host = request.protocol + request.host # create.js.erbで投稿したWorkのURL生成に使用
      flash.now[:notice] = "Workを投稿しました"
      # create.js.erbを参照する
    else
      render 'error'  # error.js.erbを参照する
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
    tag_list = params[:work][:name].split(',')
    if @work.update(work_params)
      @old_relations = WorkTag.where(work_id: @work.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @work.save_tag(tag_list)
      @tags = @work.tags
      @tag_list = @work.tags.pluck(:name).join(',')
      flash.now[:notice] = 'Workを編集しました'
      # update.js.erbを参照する
    else
      render 'error'  # error.js.erbを参照する
    end
  end

  # タグ編集用action 使用保留 現行はworks#update流用
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

  private

  def work_params
    params.require(:work).permit(:title, :caption, :user_id, :work_image)
  end

end
