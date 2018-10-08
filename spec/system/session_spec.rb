require "rails_helper"

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a new user to sign up' do
    visit '/'

    expect {
      fill_in 'Name', with: 'Caleb'
      click_on 'Play'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Pending Games'
  end

  it 'allows an existing user to login' do
    existing_user = create(:user, name: 'Caleb')
    visit '/'

    expect {
      fill_in 'Name', with: 'Caleb'
      click_on 'Play'
    }.not_to change(User, :count)

    expect(page).to have_content 'Pending Games'
  end

  it 'prevents login for blank name' do
    visit '/'

    # don't fill in name
    click_on 'Play'

    expect(page).to have_content 'error'
  end
end
