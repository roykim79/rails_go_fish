class User < ApplicationRecord
  has_many :game_users
  validates :name, presence: true, length: { maximum: 16 }
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }
end
