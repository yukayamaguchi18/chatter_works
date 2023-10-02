class CreateChatters < ActiveRecord::Migration[6.1]
  def change
    create_table :chatters do |t|
      t.integer :user_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
