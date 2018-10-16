class AddWinnerToGameUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :game_users, :winner, :boolean
  end
end
