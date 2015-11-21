class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def log_in
    email = params[:email].to_s; pwd = params[:password].to_s
    return nothing if (u = User.where(:email => email).first).nil?
    return nothing if not u.check_password?(pwd)
    sign_in(u)
    return redirect_to_root
  end
end
