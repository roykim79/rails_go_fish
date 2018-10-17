class AddWinnerToGames < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :winner, foreign_key: { to_table: :users }
  end
end
