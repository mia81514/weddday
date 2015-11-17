class TableArrange < ActiveRecord::Base
  serialize :table_info, JSON

  def self.get_valid_params(p)
    p.permit(:name, :table_info)
  end
end
