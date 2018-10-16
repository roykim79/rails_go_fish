class PlayingCard
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    "#{rank} of #{suit}"
  end

  def as_json
    { 'rank' => rank, 'suit' => suit }
  end

  def self.from_json(data)
    PlayingCard.new(data['rank'], data['suit'])
  end

  def self.collection_from_data(data)
    data.map { |card_data| PlayingCard.from_json(card_data) }
  end
end
