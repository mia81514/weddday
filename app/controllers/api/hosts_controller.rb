#=======================
# 新人後台
#=======================
class Api::HostsController < Api::BaseController

  before_filter :host_auth
  before_filter :should_has_event, :only => [
                                              :table_arranges, :create_table_arrange, :event,
                                              :questionnaires, :create_questionnaire
                                            ]

  #===============
  # 桌次安排
  #===============
  def table_arranges
    success((@event.table_arranges rescue []).as_json)
  end

  def table_arrange

  end

  def create_table_arrange
    return error("CREATE_TABLE_ARRANGE_001","NAME_EMPTY")       if params[:name].to_s       == ""
    return error("CREATE_TABLE_ARRANGE_001","TABLE_INFO_EMPTY") if params[:table_info].to_s == ""
    table_info_json = JSON.parse(params[:table_info].to_s) rescue nil
    return error("CREATE_TABLE_ARRANGE_001","INCORRECT_TABLE_INFO_JSON") if table_info_json.nil?
    valid_params  = TableArrange.get_valid_params({:name => params[:name].to_s, :table_info=>table_info_json})
    table_arrange = @event.table_arrange.new(valid_params)
    table_arrange.save
    success()
  end


  #===============
  # 活動問卷
  #===============
  def questionnaires
    success(@event.questionnaires.includes(:questionnaire_questions).as_json(Questionnaire.include_for_json))
  end

  def create_questionnaire
    qnaire   = Questionnaire.get_valid_params(params[:qnaire])
    return error("CREATE_QNAIRE_001","PARAMS_INVALID") if qnaire.nil?
    questionnaire = @event.questionnaires.new
    questionnaire.update_attributes(qnaire)
    if not params[:questions].nil?
      questions = JSON.parse(params[:questions].to_s)

    end
    success()
  end


  #===============
  # 活動相關
  #===============
  def events
    success(@event.as_json(:include => Event.include_without_q_for_json))
  end

  def event
    eid = params[:event_id]
    event = Event.where(:id=>eid).includes(:questionnaires).first
    return data_nil if event.nil?
    success(event)
  end

  def create_event
    e = Event.get_valid_params(params[:e])
    return error("CREATE_EVENT_001","PARAMS_INVALID") if e.nil?
    event = current_api_user.events.new
    event.update_attributes(e)
    success()
  end

  def update_event
    e = Event.get_valid_params(params[:e])
    return error("UPDATE_EVENT_001","PARAMS_INVALID") if e.nil?
    event = Event.find(e[:id]) rescue nil
    return error("UPDATE_EVENT_002","EVENT_NOT_FOUND") if event.nil?
    return error("UPDATE_EVENT_003","NOT_UR_EVENT") if !event.is_mine(current_api_user.id)
    event.update_attributes(e)
    success()
  end

  def event_details
    success(@event.as_json(:include => Event.include_without_q_for_json))
  end

  private
    def host_auth
      #有商家權限就導掉
      return error("HOST_AUTH_001","YOU ARE MERCHANT") if current_api_user.has_role? :merchant
    end

    def should_has_event
      event_id = params[:event_id].to_i
      @event   = current_api_user.events.includes(Event.includes_without_q).select{|e| e.id == event_id}.first
      return error("SHOULD_HAS_EVENT_001","EVENT_NOT_FOUND") if @event.nil?
    end
end
