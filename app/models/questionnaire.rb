class Questionnaire < ActiveRecord::Base
  belongs_to :event
  has_many :questionnaire_questions
  has_many :guest_replies
  has_many :guest_groups

  #女方親友
  def bride_friends
    return guest_replies.includes(:guest_group).select{|reply| reply.guest_group.is_bride}
  end

  #男方親友
  def bridegroom_friends
    return guest_replies.includes(:guest_group).select{|reply| not reply.guest_group.is_bride}
  end
end
