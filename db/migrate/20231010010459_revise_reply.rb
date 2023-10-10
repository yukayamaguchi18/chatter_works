class ReviseReply < ActiveRecord::Migration[6.1]
  def change
    rename_column :replies, :chatter_id, :reply_id
  end
end
