class ApplicationController < ActionController::Base
  before_action :require_authentication
  helper_method :current_user

  def require_authentication
    redirect_to root_path, notice: 'Login to continue' \
      unless session[:current_user_id] && current_user
  end

  def current_user
    @current_user ||= User.find session[:current_user_id]
  end
end
