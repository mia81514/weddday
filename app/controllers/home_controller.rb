class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def test_sign_in
  end

  def test_sign_out
    sign_out
    cookies.delete :login_key
    redirect_to_root
  end
end
