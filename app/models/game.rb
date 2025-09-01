class Game < ApplicationRecord
  has_many :chats
  has_many :users, through: :chats
  validates :name, presence: true, uniqueness: true
end
