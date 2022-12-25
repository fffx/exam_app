class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id] || cookies.signed[:user_id] )
  end
  def sign_out_current_user
    session[:user_id] = nil
    cookies.signed[:user_id] = nil
    @current_user = nil
  end

  helper_method :current_user
end
