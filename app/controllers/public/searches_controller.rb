class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @chatter = Chatter.new #reply用
    @model = params[:model]
    @word = params[:word] # 検索後の検索ボックスの初期値用に変数定義
    # splitで正規表現を使ってキーワードを空白(全角・半角・連続)分割する
    #   連続した空白も除去するので、最後の“+”がポイント
    @words = params[:word].split(/[[:blank:]]+/)
    if @model == 'Keyword' # Keyword検索（部分一致固定）
      # user検索結果
      @words.each_with_index do |word, i|
        # 1回目のループでは、1つ目のワードで検索
        #   結果を@usersに詰め込む
        @users = User.search(word) if i == 0
        # 2回目以降のループでは、1回目の結果を更にモデル定義の検索メソッドで絞り込みしていく
        #   結果を@usersに詰め込む
        @users = @users.merge(@users.search(word))
      end
      unless @users.blank?
        @users = @users.with_attached_profile_image
      end
      # chatter検索結果
      @words.each_with_index do |word, i|
        @chatters = Chatter.search(word) if i == 0
        @chatters = @chatters.merge(@chatters.search(word))
      end
      unless @chatters.blank?
        #search_rangeメソッドで検索範囲を絞り込み（chatterモデル参照）
        @chatters = @chatters.search_range(current_user)
        @chatters = @chatters.includes([:user, :reply_to_chatters, user: { profile_image_attachment: :blob }]).order(created_at: :desc).page(params[:page]).per(20)
      end
      # work検索結果
      @words.each_with_index do |word, i|
        @works = Work.search(word) if i == 0
        @works = @works.merge(@works.search(word))
      end
      unless @works.blank?
        @works = @works.includes([:user, user: { profile_image_attachment: :blob }]).with_attached_work_images.order(created_at: :desc).page(params[:page]).per(10)
      end
      return unless request.xhr?
      case params[:type]
      when 'chatter', 'work'
        render "public/#{params[:type]}s/page"
      end
    elsif @model == 'WorkTag' # Work Tag検索（完全一致）
      # @tag = Tag.find_by('name LIKE ?', "%#{@word}%")
      # @works = @tag.works.order(created_at: :desc)
      @words.each_with_index do |word, i|
        @tag = Tag.find_by('name LIKE ?', "#{word}")
        @works = @tag.works if i == 0
        @works = @works.merge(@tag.works)
      end
      unless @works.blank?
        @works = @works.includes([:user]).with_attached_work_images.order(created_at: :desc).page(params[:page]).per(10)
      end
      return unless request.xhr?
      case params[:type]
      when 'chatter', 'work'
        render "public/#{params[:type]}s/page"
      end
    end
  end

end
