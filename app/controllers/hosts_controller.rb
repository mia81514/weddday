class HostsController < ApplicationController

  layout 'hosts'

  def index
  end

  def test_events
  end

  #單一event的詳細資訊
  def test_event
    id=params[:id]
    @event = Event.where(:id=>id).includes(Event.includes_without_q).first
  end
end
