class GameUsersController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    game.users << current_user unless game.users.include?(current_user)
    redirect_to game_path(game)
  end
end
