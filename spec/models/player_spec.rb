# require 'spec_helper'
# require'./app/models/player'
# require './app/models/playing_card'
require 'rails_helper'

RSpec.describe Player do
  let(:player) { Player.new('Bob', 1) }
  let(:card1) { PlayingCard.new('A', 'Spades') }
  let(:card2) { PlayingCard.new('A', 'Hearts') }
  let(:card3) { PlayingCard.new('K', 'Clubs') }
  let(:cards) { [card1, card2, card3] }

  describe '#initialize' do
    it 'sets the players name' do
      expect(player.name).to eq 'Bob'
    end

    it 'starts the player with and empty hand' do
      expect(player.hand.count).to eq 0
    end
  end

  describe '#take' do
    it 'adds an array of PlayingCards to the players hand' do
      player.take([card1])
      expect(player.card_count).to eq 1
    end

    it 'adds an array of PlayingCards to the players hand' do
      player.take(cards)
      expect(player.card_count).to eq 3
    end
  end

  describe '#card_count' do
    it 'returns the number of cards the player has' do
      expect(player.card_count).to eq 0
      player.take(cards)
      expect(player.card_count).to eq 3
    end
  end

  describe '#has?' do
    it 'returns true if the player has any of the rank asked for' do
      player.take(cards)
      expect(player.has?('A')).to be true
      expect(player.has?('J')).to be false
    end
  end

  describe '#pick_rank' do
    it 'returns a card rank from the players hand' do
      player.take(cards)
      has_card = player.hand.any? { |card| card.rank == player.pick_rank }
      expect(has_card).to be true
    end
  end

  describe '#toggle_autoplay' do
    it 'toggles the autoplay between true and false' do
      expect(player.autoplay).to eq false
      player.toggle_autoplay
      expect(player.autoplay).to eq true
    end
  end

  context 'dealing with multiple cards' do
    before :each do
      player.take(cards)
    end

    describe '#give' do
      it 'returns the card(s) of a given rank from the players hand as an array' do
        expect(player.give('A')).to eq([card1, card2])
      end

      it 'removes the cards of a given rank from the players hand' do
        player.give('A')
        expect(player.hand).to eq [card3]
      end
    end

    describe '#set_count' do
      it 'returns the number of sets the player has' do
        expect(player.set_count).to be 0
      end
    end

    describe '#check_for_sets' do
      it 'will do nothing when there are not 4 of a rank in the players hand' do
        player.check_for_sets
        expect(player.card_count).to eq 3
      end

      it 'removes 4 cards of same rank and adds the rank to the sets array' do
        other_aces = [PlayingCard.new('A', 'Clubs'), PlayingCard.new('A', 'Diamonds')]
        player.take(other_aces)
        player.check_for_sets
        expect(player.card_count).to eq 1
        expect(player.set_count).to eq 1
        expect(player.sets).to eq ['A']
      end
    end
  end

  context 'saving state' do
    let(:player2) { Player.new('Jim', 2) }
    let(:players) { [player, player2] }
    let(:json_players) { players.map(&:as_json) }

    describe '#as_json' do
      it 'converts the object to a hash' do
        expect(player.as_json).to be_a Hash
        expect(player.as_json['name']).to eq 'Bob'
      end
    end

    describe '.from_json' do
      it 'returns a Player object from json data' do
        expect(Player.from_json(player.as_json)).to be_instance_of Player
      end
    end

    describe '.collection_from_data' do
      it 'returns an array of Player objects from json data' do
        return_object = Player.collection_from_data(json_players)
        expect(return_object).to be_a Array
        expect(return_object[0]).to be_instance_of Player
      end
    end
  end
end
