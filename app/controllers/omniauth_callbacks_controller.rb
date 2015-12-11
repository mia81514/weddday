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