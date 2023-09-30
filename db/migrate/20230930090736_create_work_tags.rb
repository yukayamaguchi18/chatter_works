class CreateWorkTags < ActiveRecord::Migration[6.1]
  def change
    create_table :work_tags do |t|

      t.timestamps
    end
  end
end
