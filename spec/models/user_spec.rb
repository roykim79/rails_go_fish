require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'should be valid?' do
    expect(user.valid?).to be true
  end

  it 'should have a name' do
    user.name = '     '
    expect(user.valid?).to be false
  end

  it 'should not have a name longer than 16 characters' do
    user.name = 'a' * 17
    expect(user.valid?).to be false
  end

  it 'should have a unique name' do
    duplicate_user = user.dup
    duplicate_user.name = user.name.upcase
    user.save
    expect(duplicate_user.valid?).to be false
  end
end
