class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user          = User.from_omniauth(request.env["omniauth.auth"])
    custom_params  = request.env["omniauth.params"]
    return after_success(@user, "google_oauth2", custom_params) if @user.persisted?
    redirect_to "/"
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      omniauth       = request.env["omniauth.auth"]
      fb_user_info   = omniauth["extra"]["raw_info"]
      custom_params  = request.env["omniauth.params"]
      @user.gender   = (fb_user_info["gender"] == "male") ? true : false
      @user.fb_link  = fb_user_info["link"]
      @user.locale   = fb_user_info["locale"]
      @user.birthday = fb_user_info["birthday"]
      @user.timezone = fb_user_info["timezone"]
      after_success(@user, "facebook", custom_params)


      #avatar_url     = User.process_uri(omniauth["info"]["image"])
      #@user.remote_photo_url = avatar_url
      # if !User.exists?(:provider => 'facebook', :uid=>@user.uid)
      #   @user.add_role :merchant if !custom_params.nil? and !custom_params["merchant"].nil?
      # end
      # @user.save
      # session[:fb_token] = omniauth["credentials"]["token"] if omniauth['provider'] == 'facebook'
      # split_token        = session[:fb_token].split("|")
      # fb_api_key         = split_token[0]
      # fb_session_key     = split_token[1]
      # weddday_sign_in(@user)
      # return redirect_to "/merchant" if current_user.has_role? :merchant
      # return redirect_to "/hosts"
      # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to "/"
    end
  end

  private
    def after_success(user, provider, custom_params)
      unless User.exists?(:provider => provider, :uid=>user.uid)
        user.add_role :merchant if !custom_params.nil? and !custom_params["merchant"].nil?
      end
      user.save
      weddday_sign_in(user)
      return redirect_to "/merchant" if user.has_role? :merchant
      return redirect_to "/hosts"
    end

end