class Event < ActiveRecord::Base
  belongs_to :user
  has_many :questionnaires
  has_many :table_arranges

  def find_by_name(table_name)
    return table_arranges.select{|t| t.name == table_name}.first rescue nil
  end

end
