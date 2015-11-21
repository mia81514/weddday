#used by devise(routes.rb):
#devise_for :users, :controllers => { :sessions => "custom_sessions" }
class CustomSessionsController < Devise::SessionsController
  before_filter :before_login, :only => :create
  after_filter  :after_login,  :only => :create

  def before_login
  end

  def after_login
  end
  
  def destroy
    session[:fb_token] = nil if session[:fb_token]
    rm_cached_user
    sign_out
    return redirect_to_root
  end
  
  def new
    super
  end

  def create
    email = params[:email].to_s; pwd = params[:password].to_s
    return nothing if (u = User.where(:email => email).first).nil?
    return nothing if not u.check_password?(pwd)
    sign_in(u)
    cache_user(u.id)
    return redirect_to_root
  end

private
  def cache_user(user_id)
    login_key = CacheManager.set_user!(user_id)
    cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
  end

  def rm_cached_user
    CacheManager.del_user!(cookies[:login_key])
    cookies.delete(:login_key)
  end
end