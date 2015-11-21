class CreateTableArranges < ActiveRecord::Migration
  def change
    create_table :table_arranges do |t|
      t.integer :event_id
      t.string  :name
      t.text :table_info

      t.timestamps null: false
    end
  end
end
