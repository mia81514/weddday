class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def sign_in
    email = params[:email].to_s
    return nothing if (u = User.where(:email => email).first).nil?
    #TODO timezone
    u.set_sign_in!({:current_sign_in_ip => request.remote_ip})
    return redirect_to_root
  end
end
