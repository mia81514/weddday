class AttendeeFormQuestion < ActiveRecord::Base

  TYPE_FILL_IN          = 1
  TYPE_SINGLE_CHOICE    = 2
  TYPE_MULTIPLE_CHOICE  = 3

  belongs_to :attendee_form
end
