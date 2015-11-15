class ApplicationController < ActionController::Base
  require Rails.root.join('lib', 'cache_manager.rb')
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    login_key = cookies[:login_key].to_s
    if login_key.present?
      user = CacheManager.get_current_user(login_key)
      cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
    end
    return user
  end
#############
# render
#############
  def nothing
    render(:nothing=>true)
  end

  def redirect_to_root
    redirect_to root_path
  end

  def render_json_failed(data)
    render :json => {:status => 'failed', :data => data}
  end

  def render_json_success(data='')
    render :json => {:status => 'success', :data => data}
  end

  def error_text(msg='')
    render(:text=>{:error=>msg}.to_json)
  end
end
