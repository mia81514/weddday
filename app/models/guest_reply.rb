class GuestReply < ActiveRecord::Base
  belongs_to :attendee_form
  belongs_to :guest_group
end
