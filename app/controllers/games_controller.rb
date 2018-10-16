class GamesController < ApplicationController
  def index
    Game.create_pending_games_if_needed
    @games = Game.pending
  end

  def show
    @game = Game.find(params[:id])
    @game.start
    if @game.pending?
      @other_players = @game.users.reject { |user| user == current_user }
      render :waiting
    else
      @user_player = @game.players.find { |player| player.user_id == current_user.id }
      @other_players = @game.players.reject { |player| player == @user_player }
      render :play_turn if users_turn?(@game)
    end
  end

  def update
    game = Game.find(params[:id])
    game.play_turn(params['player-name'], params['card_rank'])
    redirect_to game_path(game)
  end

  private

  def users_turn?(game)
    game.current_player.user == current_user
  end
end
