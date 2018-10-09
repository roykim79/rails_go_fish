class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :player_count

      t.timestamps
    end
  end
end
