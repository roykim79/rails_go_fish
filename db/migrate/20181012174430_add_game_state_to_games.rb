class AddGameStateToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :game_state, :jsonb
  end
end
