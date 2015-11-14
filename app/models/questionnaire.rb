class Questionnaire < ActiveRecord::Base
  TYPE_ATTENDEE         = 1  #出席調查
  TYPE_ELECTION         = 2  #投票
  TYPE_COLLECT_OPINION  = 3  #意見收集

  belongs_to :event
  has_many :questionnaire_questions
  has_many :guest_replies
  has_many :guest_groups

  def attendee_count
    return guest_replies.where(:is_attend=>true).count if self.type_id == TYPE_ATTENDEE
    return 0
  end

  #需要喜帖的資訊
  def need_invitation_list
    return guest_replies.where(:is_need_invitation=>true).as_json(:info_list=>true) if self.type_id == TYPE_ATTENDEE
    return []
  end

  #女方親友
  def bride_friends_replies
    return guest_replies.includes(:guest_group).select{|reply| reply.guest_group.is_bride}
  end

  #男方親友
  def bridegroom_friends_replies
    return guest_replies.includes(:guest_group).select{|reply| not reply.guest_group.is_bride}
  end
end
