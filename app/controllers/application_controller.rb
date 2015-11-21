class ApplicationController < ActionController::Base
  require Rails.root.join('lib', 'cache_manager.rb')
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :only => [:sign_out]

  alias_method :devise_current_user, :current_user

  def current_user
    login_key = cookies[:login_key]
    return nil if login_key.nil?
    user = CacheManager.get_current_user(login_key)
    cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
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
end
