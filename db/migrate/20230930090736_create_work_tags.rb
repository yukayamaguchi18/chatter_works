class CreateWorkTags < ActiveRecord::Migration[6.1]
  def change
    create_table :work_tags do |t|
      t.integer :user_id, null: false
      t.integer :work_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
