class ReviseComment < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment_to_id, :work_id
    add_column :comments, :user_id, :string, null: false
  end
end
