require "rails_helper"

RSpec.describe 'Session', type: :system do
  def sign_up(name)
    visit root_path
    fill_in 'Name', with: name
    click_on 'Play'
  end

  before do
    driven_by(:rack_test)
  end

  it 'allows a new user to sign up' do
    visit root_path

    expect {
      fill_in 'Name', with: 'Roy'
      click_on 'Play'
    }.to change(User, :count).by 1

    expect(page).to have_content 'Pending Games'
  end

  it 'allows an existing user to login' do
    existing_user = create(:user, name: 'Roy')
    visit root_path

    expect {
      fill_in 'Name', with: 'Roy'
      click_on 'Play'
    }.not_to change(User, :count)

    expect(page).to have_content 'Pending Games'
  end

  it 'prevents login for blank name' do
    visit root_path

    # don't fill in name
    click_on 'Play'

    expect(page).to have_css 'input[id=user_name]'
  end

  it 'allows the user to join a pending game' do
    sign_up('Roy')

    expect {
      click_on '2 Player'
    }.to change(GameUser, :count).by 1
  end

  it 'prevents user from joining game more than once' do
    sign_up('Roy')
    click_on '2 Player'
    visit games_path

    expect {
      click_on '2 Player'
    }.not_to change(GameUser, :count)
  end
end
