class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :event_id
      t.integer :type_id #出席調查，意願調查，意見投票等等
      t.string  :name
      t.text    :desc
      t.string  :cover
      t.string  :cowork_code #協作代碼:日後可以共同編輯參加表單
      t.datetime  :date_start
      t.datetime  :date_end

      t.timestamps null: false
    end

    add_index(:questionnaires, [:event_id, :date_end])
    add_index(:questionnaires, [:event_id, :date_start])
  end
end
