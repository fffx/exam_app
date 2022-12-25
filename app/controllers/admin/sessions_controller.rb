class Admin::SessionsController < Admin::AdminController
  def create
    return redirect_to admin_root_path if current_user
    return render :login unless request.post?

    teacher = User.teachers.find_by(email: params[:email])
    return redirect_to admin_root_path, flash: {error: "Account not found or you are not a teacher"} if teacher.nil?

    if teacher.authenticate params[:password]
      session[:user_id] = teacher.id
      if params[:remember_me] == '1'
        cookies.signed[:user_id] = {
          value: teacher.id,
          expires: 3.weeks.from_now
        }
      end

      redirect_to admin_root_path, flash: {notice: "Login successful."}
    else
      redirect_to admin_root_path, flash: {error: "Password does not match."}
    end
  end

  def destroy
    sign_out_current_user
    redirect_to admin_root_path
  end
end
