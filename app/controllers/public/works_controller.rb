class Public::WorksController < ApplicationController
  def new
  end

  def show
    @work = Work.find(params[:id])
    @tags = @work.tags
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:work][:name].split(',')
    if @work.save
      @work.save_tag(tag_list)
      @works = Work.where(user_id: [current_user.id, *current_user.followings])
      @host = request.protocol + request.host
      flash.now[:notice] = "Workを投稿しました"
      #redirect_to work_path(@work) ,notice:'作品を投稿しました'
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

  end

  private

  def work_params
    params.require(:work).permit(:title, :caption, :user_id, :work_image)
  end

end
