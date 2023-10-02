class CreateRechatters < ActiveRecord::Migration[6.1]
  def change
    create_table :rechatters do |t|
      t.integer :user_id, null: false
      t.integer :chatter_id, null: false

      t.timestamps
    end
  end
end
