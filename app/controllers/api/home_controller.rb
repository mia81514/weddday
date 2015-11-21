#=======================
#  首頁
#=======================
class Api::HomeController < Api::BaseController
  before_filter :authenticate_user!
  
  def sign_out
  end
end