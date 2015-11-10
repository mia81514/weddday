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
    super
    facebook_logout
    session[:fb_token] = nil if session[:fb_token]
  end
  
  def new
    loginkey = cookies[:guideu]
    if loginkey != nil
      # user_obj = CacheManager.get_current_user(loginkey)
      # if user_obj!= nil
        # sign_in(user_obj) #devise helpers
        # redirect_to '/'
      # end
    end
  end
  
end