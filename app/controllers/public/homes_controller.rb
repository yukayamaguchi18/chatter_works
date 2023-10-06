class Public::HomesController < ApplicationController
  def top
    @chatters = Chatter.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    @works = Work.where(user_id: [current_user.id, *current_user.followings]).order(created_at: :desc)
    @chatter = Chatter.new
    @work = Work.new
  end
end
