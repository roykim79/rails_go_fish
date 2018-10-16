require_relative './playing_card'

class CardDeck
  attr_accessor :cards

  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  SUITS = %w[Spades Hearts Clubs Diamonds].freeze

  def initialize(cards = CardDeck.full_deck)
    @cards = cards
  end

  def count
    cards.count
  end

  def deal
    cards.pop
  end

  def shuffle
    cards.shuffle!
  end

  def as_json
    { 'cards' => cards.map(&:as_json) }
  end

  def self.from_json(data)
    CardDeck.new(PlayingCard.collection_from_data(data['cards']))
  end

  def self.full_deck
    RANKS.flat_map { |rank| SUITS.map { |suit| PlayingCard.new(rank, suit) } }
  end
end
