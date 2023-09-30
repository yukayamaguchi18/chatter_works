class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|

      t.timestamps
    end
  end
end
