class User < ApplicationRecord
  has_many :game_users, dependent: :destroy
  has_many :games, through: :game_users
  validates :name, presence: true,
                   length: { maximum: 16 },
                   uniqueness: { case_sensitive: false }
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }
end
