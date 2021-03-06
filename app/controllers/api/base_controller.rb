class Api::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :valid_client_auth , :except => [:do_sign_in, :do_sign_in]

  def do_sign_in
    email = params[:email].to_s; pwd = params[:password].to_s
    return error("SIGN_IN_001", "NO_USER_EXISTS") if (u = User.where(:email => email).first).nil?
    return erorr("SIGN_IN_002", "PASSWORD_INCORRECT") if not u.check_password?(pwd)
    weddday_sign_in(u)
    success()
  end

  def do_sign_out
    weddday_sign_out
    success()
  end

  def set_locale
    locale = params[:locale].to_s
    return error("SET_LOCALE_001", "UNAVAILABLE_LOCALE") if I18n.available_locales.map(&:to_s).exclude?(locale)
    current_api_user.set_locale!(locale)
    return success()
  end

  def valid_client_auth
    return error("Deny!") if current_api_user.nil?
  end

  def current_api_user
    return current_user  #TODO 區分web與其他地方來的client (:api)
  end

  #=================
  # General Error
  #=================
  def user_not_found
    error("GENERAL001", "User Not Found")
  end

  def wrong_params
    error("GENERAL003", "Incorrect Parameters")
  end

  def data_nil
    error("GENERAL004","data nil")
  end

  def illegal_operation
    error("GENERAL005","Illegal Operation")
  end

  private
    def error(code="", message="")
      render :json => {:status=>"error", :data =>{ :code=>code, :message=>message} }
    end

    def success(info={})
      render :json => {:status=>"success", :data=>info}
    end
end
