class GamesController < ApplicationController
  before_action :require_authentication

  # def require_authentication
  #   unless session[:current_user] && current_user
  #     redirect_to new_session_path, notice: 'Login to continue'
  #   end
  # end
  #
  # def current_user
  #   @current_user ||= User.find session[:current_user]
  # end

  def index
  end

  def show
  end
end
