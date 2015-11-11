class CreateAttendeeForms < ActiveRecord::Migration
  def change
    create_table :attendee_forms do |t|
      t.integer :user_id
      t.string :cowork_code
      t.string :title
      t.string :city
      t.string :district
      t.string :address
      t.string :place_name
      t.datetime :wedding_date
      t.datetime :fill_start
      t.datetime :fill_end

      t.timestamps null: false
    end
  end
end
