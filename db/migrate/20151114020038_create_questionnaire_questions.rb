class CreateQuestionnaireQuestions < ActiveRecord::Migration
  def change
    create_table :questionnaire_questions do |t|

      t.integer :questionnaire_id
      t.integer :q_type
      t.string :title
      t.text :selections

      t.timestamps null: false
    end

    add_index(:questionnaire_questions, [ :questionnaire_id, :q_type ])
  end
end
