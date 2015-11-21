#=======================
#  首頁
#=======================
class Api::HomeController < Api::BaseController
  before_filter :authenticate_user!
  
  def sign_out
    rm_cached_user
    sign_out
    success()
  end
  private
    def rm_cached_user
      CacheManager.del_user!(cookies[:login_key])
      cookies.delete(:login_key)
    end
end