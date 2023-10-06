class Public::SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @word = params[:word]
    if @model == '1' # Keyword検索
      @users = User.where('name LIKE ?', '%' + @word + '%').or(User.where('introduction LIKE ?', '%' + @word + '%'))
      @chatters = Chatter.where('body LIKE ?', '%' + @word + '%')
      @works = Work.where('title LIKE ?', '%' + @word + '%').or(Work.where('caption LIKE ?', '%' + @word + '%'))
    elsif @model == '2' # Work Tag検索
      @works = Work.where(name: @content)
    end
  end
  
end
