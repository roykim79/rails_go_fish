class Player
  attr_accessor :name, :user_id, :hand, :sets, :autoplay

  def initialize(name, user_id, hand = [], sets = [], autoplay = false)
    @name = name
    @user_id = user_id
    @hand = hand
    @sets = sets
    @autoplay = autoplay
  end

  def user
    User.find(user_id)
  end

  def give(rank)
    cards = hand.select { |card| card.rank == rank }
    hand.reject! { |card| card.rank == rank }
    cards
  end

  def take(cards)
    cards.each { |card| hand.push(card) }
  end

  def card_count
    hand.count
  end

  def set_count
    sets.count
  end

  def has?(rank)
    hand.any? { |card| card.rank == rank }
  end

  def pick_rank
    hand.sample.rank
  end

  def toggle_autoplay
    self.autoplay = !autoplay
  end

  def check_for_sets
    sets_made = []
    hand.each do |card_to_match|
      rank = card_to_match.rank
      sets_made.push(rank) if complete_set?(rank) && !sets.include?(rank)
    end
    return if sets_made.count.zero?

    pull_sets_from_hand(sets_made.uniq!)
    sets_made
  end

  def as_json
    {
      'name' => name,
      'user_id' => user_id,
      'hand' => hand.map(&:as_json),
      'sets' => sets,
      'autoplay' => false
    }
  end

  def self.from_json(data)
    Player.new(
      data['name'],
      data['user_id'],
      PlayingCard.collection_from_data(data['hand']),
      data['sets'],
      data['autoplay']
    )
  end

  def self.collection_from_data(data)
    data.map { |player_data| Player.from_json(player_data) }
  end

  private

  def complete_set?(rank)
    hand.count { |card| card.rank == rank } == 4
  end

  def pull_sets_from_hand(ranks)
    ranks.each do |rank|
      hand.reject! { |card| card.rank == rank }
      sets.push(rank)
    end
  end
end
