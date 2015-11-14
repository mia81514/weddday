class GuestReply < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :guest_group

  def as_json(options={})
    if options.fetch(:info_list, false)
      hash = {}
      hash[:name]         = self.name
      hash[:phone]        = self.phone
      hash[:full_address] = self.zip_code + self.city + self.district + self.address
      return hash
    else
      super(options)
    end
  end
end
