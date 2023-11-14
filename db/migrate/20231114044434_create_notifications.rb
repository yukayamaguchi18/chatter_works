class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :chatter_id
      t.integer :reply_id
      t.integer :work_id
      t.integer :comment_id
      t.string :action, null: false, default: ''
      t.boolean :is_checked, null: false, default: false
      
      t.timestamps
    end
  end
end
