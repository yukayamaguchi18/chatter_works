class AddChatterFavoritesCountToChatters < ActiveRecord::Migration[6.1]
  def self.up
    add_column :chatters, :chatter_favorites_count, :integer, null: false, default: 0
    add_column :chatters, :rechatters_count, :integer, null: false, default: 0
    add_column :chatters, :reply_to_chatters_count, :integer, null: false, default: 0
    add_column :tags, :work_tags_count, :integer, null: false, default: 0
    add_column :users, :chatters_count, :integer, null: false, default: 0
    add_column :users, :chatter_favorites_count, :integer, null: false, default: 0
    add_column :users, :works_count, :integer, null: false, default: 0
    add_column :users, :work_favorites_count, :integer, null: false, default: 0
    add_column :users, :followings_count, :integer, null: false, default: 0
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :receiving_requests_count, :integer, null: false, default: 0
    add_column :works, :work_favorites_count, :integer, null: false, default: 0
    add_column :works, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :chatters, :chatter_favorites_count
    remove_column :chatters, :rechatters_count
    remove_column :chatters, :reply_to_chatters_count
    remove_column :tags, :work_tags_count
    remove_column :users, :chatters_count
    remove_column :users, :chatter_favorites_count
    remove_column :users, :works_count
    remove_column :users, :work_favorites_count
    remove_column :users, :followings_count
    remove_column :users, :followers_count
    remove_column :users, :receiving_requests_count
    remove_column :works, :work_favorites_count
    remove_column :works, :comments_count
  end
end
