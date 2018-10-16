class GameUser < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates_uniqueness_of :user, scope: :game
end
