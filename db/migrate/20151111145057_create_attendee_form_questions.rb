class CreateAttendeeFormQuestions < ActiveRecord::Migration
  def change
    create_table :attendee_form_questions do |t|
      t.integer :attendee_form_id
      t.integer :q_type
      t.string :title
      t.text :selections

      t.timestamps null: false
    end

    add_index(:attendee_form_questions, [ :attendee_form_id, :q_type ])
  end
end
