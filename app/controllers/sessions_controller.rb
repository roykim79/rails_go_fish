class SessionsController < ApplicationController
  skip_before_action :require_authentication

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by user_params
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to games_path, notice: 'Logged in successfully'
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
