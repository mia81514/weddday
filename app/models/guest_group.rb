class GuestGroup < ActiveRecord::Base
  belongs_to :attendee_form
  has_many :guest_replies
end
