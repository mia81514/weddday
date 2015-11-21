class CreateGuestGroups < ActiveRecord::Migration
  def change
    create_table :guest_groups do |t|
      t.integer :questionnaire_id
      t.string :name
      t.boolean :is_bride

      t.timestamps null: false
    end
  end
end
