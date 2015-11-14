class ApplicationController < ActionController::Base
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
end
