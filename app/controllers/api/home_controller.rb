#=======================
#  首頁
#=======================
class Api::HomeController < Api::BaseController
  before_filter :authenticate_user!, :except => [:sign_in, :sign_up]
  
end