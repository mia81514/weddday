#=======================
#  首頁
#=======================
class Api::HomeController < Api::BaseController
  before_filter :authenticate_user!

end