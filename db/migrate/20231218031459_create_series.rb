class CreateSeries < ActiveRecord::Migration[6.1]
  def change
    create_table :series do |t|
      t.integer :user_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :series, [:user_id, :name], unique: true
    add_column :works, :public_status, :integer, null: false, default: 0

  end
end
