require 'rails_helper'

class TestDeck < CardDeck
  RANKS = %w[A K Q J].freeze
  SUITS = %w[Spades Hearts Clubs Diamonds].freeze

  def from_json(data)
    TestDeck.new(PlayingCard.collection_from_data(data['cards']))
  end

  def initialize(cards = TestDeck.full_deck)
    @cards = cards
  end

  def self.full_deck
    RANKS.flat_map { |rank| SUITS.map { |suit| PlayingCard.new(rank, suit) } }
  end

  def shuffle

  end
end

RSpec.describe GoFish do
  let(:player1) { Player.new('Jim', 1) }
  let(:player2) { Player.new('Bob', 2) }
  let(:game) { GoFish.new([player1, player2]) }

  describe '#initialization' do
    it 'has a deck' do
      expect(game.deck).not_to be_nil
    end
  end

  describe '#start' do
    it 'deals out cards to each player' do
      game.start
      game.players.each { |player| expect(player.hand.count).to eq 7 }
    end
  end

  describe '#current_player' do
    it 'returns the player whose turn the game is on' do
      expect(game.current_player).to be player1
    end
  end

  describe '#next_player' do
    it 'changes the current_player to the next index of players' do
      game.next_player
      expect(game.current_player).to be player2
      game.next_player
      expect(game.current_player).to be player1
    end
  end

  describe '#play_turn' do
    it 'will change the number of cards current player has' do
      game.start
      expect { game.play_turn(player2, 'A') }.to change(player1, :card_count)
    end
  end

  describe '#winner' do
    it 'is nill at first' do
      game.start
      expect(game.winner).to be_nil
    end

    it 'returns the player with no cards left' do
      player1.take(%w[A].flat_map { |rank| %w[S H].map { |suit| PlayingCard.new(rank, suit) } })
      player2.take(%w[A K].flat_map { |rank| %w[C D].map { |suit| PlayingCard.new(rank, suit) } })
      rigged_game = GoFish.new([player1, player2])
      rigged_game.play_turn(player2, 'A')
      expect(rigged_game.winner).to be player1
    end

    it 'returns the player with the most sets if the deck count is 0' do
      rigged_hand1 = %w[A Q].flat_map { |rank| %w[S H C].map { |suit| PlayingCard.new(rank, suit) } }
      rigged_hand2 = %w[K].flat_map { |rank| %w[S H C].map { |suit| PlayingCard.new(rank, suit) } }
      rigged_deck = CardDeck.new(%w[A].flat_map { |rank| %w[D].map { |suit| PlayingCard.new(rank, suit) } })
      player1.take(rigged_hand1)
      player2.take(rigged_hand2)
      rigged_game = GoFish.new([player1, player2], rigged_deck)
      expect { rigged_game.play_turn(player2, 'A') }.to change { rigged_game.winner }.to player1
    end
  end

  context 'saving and reading json data' do
    let(:json_game) { game.as_json }

    describe '#as_json' do
      it 'returns a hash of the Game object' do
        expect(json_game).to be_a Hash
        expect(json_game['players'].count).to eq 2
      end
    end

    describe '.from_json' do
      it 'returns a GoFish object from json data' do
        return_object = GoFish.from_json(json_game)
        expect(return_object).to be_instance_of GoFish
        expect(return_object.players.count).to eq 2
      end
    end
  end
end
