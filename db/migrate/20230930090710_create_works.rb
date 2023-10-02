class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :caption, null: false

      t.timestamps
    end
  end
end
