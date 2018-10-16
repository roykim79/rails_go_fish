require 'spec_helper'
require './app/models/playing_card'

describe PlayingCard do
  let(:card) { PlayingCard.new('A', 'Spades') }
  let(:card2) { PlayingCard.new('K', 'Clubs') }

  describe '#rank' do
    it 'returns the rank of the card' do
      expect(card.rank).to eq 'A'
    end
  end

  describe '#suit' do
    it 'returns the suit of the card' do
      expect(card.suit).to eq 'Spades'
    end
  end

  describe '#value' do
    it 'returns the rank and suit of a card as a string' do
      expect(card.value).to eq 'A of Spades'
    end
  end

  context 'saving and reading json' do
    let(:json_card) { card.as_json }
    let(:card_from_json) { PlayingCard.from_json(json_card) }
    let(:cards) { [card, card2] }
    let(:json_cards) { cards.map(&:as_json) }

    describe '#as_json' do
      it 'turns the json of a card to a PlayingCard object' do
        expect(json_card['rank']).to eq 'A'
        expect(json_card['suit']).to eq 'Spades'
      end
    end

    describe '.from_json' do
      it 'returns a PlayingCard object from json data' do
        expect(card_from_json).to be_instance_of PlayingCard
        expect(card_from_json.rank).to eq 'A'
        expect(card_from_json.suit).to eq 'Spades'
      end
    end

    describe '.collection_from_data' do
      it 'returns an array' do
        expect(PlayingCard.collection_from_data(json_cards)).to be_a Array
      end

      it 'returns an array of PlayingCard objects' do
      expect(PlayingCard.collection_from_data(json_cards)[0]).to be_instance_of PlayingCard
      end
    end
  end
end
