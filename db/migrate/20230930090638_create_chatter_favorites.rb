class CreateChatterFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :chatter_favorites do |t|

      t.timestamps
    end
  end
end
