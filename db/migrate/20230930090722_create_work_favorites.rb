class CreateWorkFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :work_favorites do |t|

      t.timestamps
    end
  end
end
