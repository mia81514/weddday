class Api::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :valid_client_auth #, :except => [:sign_in, :sign_up]


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

  def gc_not_found
    error("GENERAL002", "Gc Not Found")
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
