class GuestGroup < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :guest_replies
end
