class Admin::UsersController < Admin::AdminController
  before_action :load_user!, only: [:update, :destroy, :edit, :show]
  def index
    return redirect_to(admin_login_path) unless current_user

    @users = User.order(Arel.sql("CASE WHEN users.role='teacher' THEN 0 ELSE 1 END")).all
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :invalid_user, status: :unprocessable_entity
      # respond_to do |format|
      #   format.html { redirect_to admin_users_path }
      #   format.turbo_stream {
      #   }
      # end
    end
  end


  def edit

  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :invalid_user, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @user.id
      return redirect_to admin_users_path, notice: "You can't delete yourself."
    end

    @user.destroy
    redirect_to admin_users_path, notice: 'Deleted successfully.'
  end

  def new
    @user = User.new
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :role, :name, :password_confirmation)
  end

  def load_user!
    # debugger
    @user = User.find(params[:id])
  end
end
