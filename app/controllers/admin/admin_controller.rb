class Admin::AdminController < ApplicationController
  def authenticate!
    if current_user.nil?
      redirect_to admin_root_path
    elseif current_user.student?
      sign_out_current_user
      redirect_to admin_root_path
    end
  end
end
