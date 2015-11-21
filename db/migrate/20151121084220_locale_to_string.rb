class LocaleToString < ActiveRecord::Migration
  def up
    change_column :users, :locale, :string
  end

  def down
    change_column :users, :locale, :datetime
  end
end
