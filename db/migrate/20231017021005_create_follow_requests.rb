class CreateFollowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_requests do |t|

      t.references :sender, foreign_key: {to_table: :users}
      t.references :receiver, foreign_key: {to_table: :users}

      t.timestamps

      t.index [:sender_id, :receiver_id], unique: true
    end
  end
end
