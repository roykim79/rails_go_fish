class GamesController < ApplicationController
  def index
    Game.start_pending_games_if_needed
    @games = Game.pending
  end

  def show
    @game = Game.find(params[:id])
    @user = User.find(session[:current_user])
    @game_user = GameUser.find_or_create_by(
      game_id: @game.id, user_id: @user.id)
  end
end
