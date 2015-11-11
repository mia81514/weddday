class AttendeeForm < ActiveRecord::Base
  belongs_to :user
  has_many :attendee_form_questions
  has_many :guest_replies
  has_many :guest_groups
end
