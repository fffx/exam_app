class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].to_s.split(' ').last
      Rails.logger.debug { "Authentication: #{token}"}
      @current_user = User.find_by(token: token)
      if @current_user.nil?
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Authorization header is missing' }, status: :unauthorized
    end
  end


  def current_user
    @current_user
  end
end
