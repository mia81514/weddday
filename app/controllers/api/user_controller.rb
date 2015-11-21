#=======================
# 新人後台
#=======================
class Api::UserController < Api::BaseController
  before_filter :valid_client_auth

  def set_locale
    locale = params[:locale].to_s
    return error("SET_LOCALE_001", "UNAVAILABLE_LOCALE") if I18n.available_locales.map(&:to_s).exclude?(locale)
    current_api_user.set_locale!(locale)
    return success()
  end
end
