class ApplicationController < ActionController::Base
  require Rails.root.join('lib', 'cache_manager.rb')
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    login_key = cookies[:login_key]
    return nil if login_key.nil?
    user = CacheManager.get_current_user(login_key)
    cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
    return user
  end

  def weddday_sign_out
    sign_out
    CacheManager.del_user!(cookies[:login_key])
    cookies.delete(:login_key)
  end

  def weddday_sign_in(user)
    sign_in(user)
    cache_user(user.id)
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

  def cache_user(user_id)
    login_key = CacheManager.set_user!(user_id)
    cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
  end
end
