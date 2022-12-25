class UsersController < ApplicationController
  before_action :authenticate!, except: [:login]

  def index
    return redirect_to(admin_login_path) unless current_user

    @users = User.order(Arel.sql("CASE WHEN users.role='teacher' THEN 0 ELSE 1 END")).all
  end

  def destroy
    user = User.find_by_id(params[:id]))
  end

  def login
    return render :login unless request.post?

    teacher = User.teachers.find_by(email: params[:email])
    return redirect_to admin_root_path, flash: {notice: "Account not found or you are not a teacher"} if teacher.nil?


    if teacher.authenticate params[:password]
      session[:user_id] = teacher.id
      redirect_to admin_root_path, flash: {notice: "Login successful"}
    else
      redirect_to admin_root_path, flash: {notice: "Password does not match."}
    end
  end
end
