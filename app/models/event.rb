class Event < ActiveRecord::Base
  belongs_to :user
  has_many :questionnaires
  has_many :table_arranges

  def self.except_attr_for_view
    return [:city, :district, :address]
  end

  def as_json(options={})
    if options.fetch(:view, false)
      hash = super(:except => Event.except_attr_for_view)
      hash[:full_address] = self.city.to_s + self.district.to_s + self.address.to_s if self.has_location
      return hash
    else
      super(options)
    end
  end

  def find_by_name(table_name)
    return table_arranges.select{|t| t.name == table_name}.first rescue nil
  end

  def self.include_without_q_for_json
    return {:questionnaires=>{:methods => [:guest_replies,:guest_groups]}, :table_arranges=>{}}
  end

  #includes除了問卷題目
  def self.includes_without_q
    return [{:questionnaires=>[:guest_replies,:guest_groups]}, :table_arranges]
  end

end
