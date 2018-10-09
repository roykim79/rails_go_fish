require "rails_helper"

RSpec.describe 'Games', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'requires authentication' do
    visit '/games'

    expect(page).to have_css 'input[id=user_name]'
    expect(current_path).to eq new_session_path
  end

  # it 'starts a game when enough players join' do
  # end
end
