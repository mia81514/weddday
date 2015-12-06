#=======================
# 新人後台
#=======================
class Api::UserController < Api::BaseController
  before_filter :valid_client_auth

end
