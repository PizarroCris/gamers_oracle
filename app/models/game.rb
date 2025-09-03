class Game < ApplicationRecord
  has_one_attached :image
  has_many :chats, dependent: :destroy
  has_many :users, through: :chats
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
end
