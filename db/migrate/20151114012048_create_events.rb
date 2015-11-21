class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer   :user_id
      t.integer   :type_id
      t.string    :name
      t.text      :desc
      t.boolean   :has_location, :default=>false
      t.string    :cover
      t.string    :city
      t.string    :district
      t.string    :address
      t.string    :place_name
      t.datetime  :holding_date
      t.datetime  :date_start
      t.datetime  :date_end

      t.timestamps null: false
    end

    add_index(:events, [:user_id, :type_id])
    add_index(:events, [:user_id, :city])
    add_index(:events, [:user_id, :date_end])
    add_index(:events, [:user_id, :date_start])
  end

end
