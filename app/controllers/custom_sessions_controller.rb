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

  end
end