class AttendeeForm < ActiveRecord::Base
  belongs_to :user
  has_many :attendee_form_questions
  has_many :guest_replies
  has_many :guest_groups

  def attendee_count
    return guest_replies.where(:is_attend=>true).count
  end

  #需要喜帖的資訊
  def need_invitation_list
    return guest_replies.where(:is_need_invitation=>true).as_json(:info_list=>true)
  end

  #女方親友
  def bride_friends
    return guest_replies.includes(:guest_group).select{|reply| reply.guest_group.is_bride}
  end

  #男方親友
  def bridegroom_friends
    return guest_replies.includes(:guest_group).select{|reply| not reply.guest_group.is_bride}
  end
end
