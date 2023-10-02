class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.integer :chatter_id, null: false
      t.integer :reply_to_id, null: false

      t.timestamps
    end
  end
end
