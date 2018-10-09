class Game < ApplicationRecord
  has_many :game_users
  scope :pending, -> { where(started_at: nil) }

  def self.start_pending_games_if_needed
    (2..5).each do |player_count|
      if Game.where(player_count: player_count).count.zero?
        game = Game.new(player_count: player_count)
        game.save
      end
    end
  end
end
