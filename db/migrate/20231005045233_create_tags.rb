class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_column :work_tags, :tag_id, :integer, null: false
    remove_column :work_tags, :user_id, :integer
    remove_column :work_tags, :name, :string
    add_index :work_tags, [:work_id, :tag_id], unique: true
  end
end
