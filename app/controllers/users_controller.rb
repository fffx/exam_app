class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login]


  # params: email, password
  # @return token
  #
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      user.regenerate_token
      render json: { token: user.token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  def logout
    current_user.regenerate_token
    render json: {success: true}, status: :ok
  end
end
