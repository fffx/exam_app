class ApplicationController < ActionController::Base
  before_action :set_back_path


  private

  def set_back_path

    @back_path = if request.referer.blank?
      admin_root_path
    elsif request.referer.end_with?(request.path)
      request.path =~ /^\/admin\/tests\// ? admin_tests_path : admin_users_path
    else
      request.referer
    end
  end

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
