class CreateWorkFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :work_favorites do |t|
      t.integer :user_id, null: false
      t.integer :work_id, null: false

      t.timestamps
    end
  end
end
