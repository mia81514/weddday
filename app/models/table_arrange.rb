class TableArrange < ActiveRecord::Base
  serialize :table_info, JSON
end
