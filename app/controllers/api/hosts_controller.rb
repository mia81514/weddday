#=======================
# 新人後台
#=======================
class Api::HostsController < Api::BaseController

  before_filter :host_auth
  before_filter :should_has_event, :only => [:table_arranges, :create_table_arrange]

  def table_arranges
    success((@event.table_arranges rescue []).as_json)
  end

  def create_table_arrange
    return error("CREATE_TABLE_ARRANGE_001","NAME_EMPTY")       if params[:name].to_s       == ""
    return error("CREATE_TABLE_ARRANGE_001","TABLE_INFO_EMPTY") if params[:table_info].to_s == ""
    table_info_json = JSON.parse(params[:table_info].to_s) rescue nil
    return error("CREATE_TABLE_ARRANGE_001","INCORRECT_TABLE_INFO_JSON") if table_info_json.nil?
    table_arrange = @event.table_arrange.new({:name => params[:name].to_s, :table_info=>table_info_json})
    table_arrange.save
    success()
  end

  private
    def host_auth
      #有商家權限就導掉
    end

    def should_has_event
      event_id = params[:event_id].to_i
      @event   = current_api_user.events.select{|e| e.id == event_id}.first
      return error("SHOULD_HAS_EVENT_001","EVENT_NOT_FOUND") if @event.nil?
    end
end
