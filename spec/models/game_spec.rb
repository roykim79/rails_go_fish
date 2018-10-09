require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should have pending games' do
    Game.start_pending_games_if_needed
    expect(Game.pending.count).to eq 4
  end
end
