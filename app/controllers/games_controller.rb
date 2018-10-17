class GamesController < ApplicationController
  def index
    Game.create_pending_games_if_needed
    @games = Game.pending
  end

  def show
    @game = Game.find(params[:id])

    if @game.pending?
      @game.start
      render :waiting
    elsif @game.winner
      render :game_over
    elsif users_turn?(@game)
      render :play_turn
    end
  end

  def update
    game = Game.find(params[:id])
    game.play_turn(params['player-name'], params['card_rank'])
    redirect_to game_path(game)
  end

  # def check_for_win(game)
  #   puts 'A'
  #   if game.winner
  #     game.update(ended_at: Time.zone.now)
  #     puts 'B'
  #     ###############################################################
  #     # game_user.update(winner: true)
  #   end
  # end

  private

  def users_turn?(game)
    game.current_player.user == current_user
  end
end
