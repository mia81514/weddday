class AddPersonalInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :name    , :string
    add_column :users, :gender  , :boolean
    add_column :users, :fb_link , :string
    add_column :users, :birthday, :datetime
    add_column :users, :locale  , :datetime
    add_column :users, :timezone, :string
  end
end
