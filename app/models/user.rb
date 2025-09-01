class User < ApplicationRecord
  has_many :chats
  has_many :games, through: :chats
  has_many :messages, through: :chats

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
