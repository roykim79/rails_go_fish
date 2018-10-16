require 'rails_helper'

RSpec.describe GameUser, type: :model do
  let(:game_user) { GameUser.new(user_id: 1, game_id: 1) }

  it 'should be unique' do
    duplucate_game_user = game_user.dup
    expect(duplucate_game_user.valid?).to be false
  end
end
