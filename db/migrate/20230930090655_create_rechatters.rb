class CreateRechatters < ActiveRecord::Migration[6.1]
  def change
    create_table :rechatters do |t|

      t.timestamps
    end
  end
end
