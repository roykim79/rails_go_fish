require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create(:game, player_count: 2) }
  let(:user1) { create(:user, name: 'Roy') }
  let(:user2) { create(:user, name: 'John') }

  describe '.create_pending_games_if_needed' do
    it 'will create a pending game for each player_count' do
      expect(Game.all.count).to eq 0
      Game.create_pending_games_if_needed
      expect(Game.pending.count).to eq 4
    end

    it 'will create a new game after one has started' do
      Game.create_pending_games_if_needed
      test_game = Game.pending.find_by(player_count: 2)
      test_game.users << user1 << user2
      test_game.start
      expect(Game.in_progress.count).to eq 1

      Game.create_pending_games_if_needed
      expect(Game.pending.count).to eq 4
    end
  end

  describe '#start' do
    it 'will not update started_at when called on a game with enough players' do
      game.users << user1
      expect { game.start }.to_not change(game, :started_at)
    end

    it 'will start a game with enough players' do
      game.users << user1 << user2
      expect { game.start }.to change(game, :started_at)
    end

    it 'will update game_state with a serialized GoFish object' do
      game.users << user1 << user2
      game.start
      expect(game.game_state).not_to be_nil
    end

    # it 'will create a player object for each game user' do
    #   game.users << user1 << user2
    #   game.start
    #   expect(game.players.count).to eq 2
    # end
  end
end
