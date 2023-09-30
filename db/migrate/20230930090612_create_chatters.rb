class CreateChatters < ActiveRecord::Migration[6.1]
  def change
    create_table :chatters do |t|

      t.timestamps
    end
  end
end
