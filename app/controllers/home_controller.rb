class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def test_sign_in
  end

  def test_sign_out
    weddday_sign_out
    redirect_to_root
  end
end
