class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def sign_in
    email = params[:email].to_s
    return nothing if (u = User.where(:email => email).first).nil?
    return nothing if not u.check_password?(params[:password].to_s)
    #TODO timezone
    u.set_sign_in!({:current_sign_in_ip => request.remote_ip})
    cache_user(u.id)
    return redirect_to_root
  end

  def sign_up
    err_msgs = User.set_sign_up!(params[:email].to_s, params[:password].to_s)
    return render_json_failed(err_msgs) if err_msgs.any?
    return render_json_success
  end

private
  def cache_user(user_id)
    login_key = CacheManager.set_user!(user_id)
    cookies[:login_key] = {:value => login_key, :expires => 1.day.from_now}
  end
end
