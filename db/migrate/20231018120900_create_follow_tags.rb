class CreateFollowTags < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_tags do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    add_index :follow_tags, [:user_id, :tag_id], unique: true
    add_index :chatter_favorites, [:user_id, :chatter_id], unique: true
    add_index :rechatters, [:user_id, :chatter_id], unique: true
    add_index :relationships, [:followed_id, :follower_id], unique: true
    add_index :work_favorites, [:user_id, :work_id], unique: true
  end
end
