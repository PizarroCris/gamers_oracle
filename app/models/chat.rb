class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :game, dependent: :destroy
  has_many :messages, dependent: :destroy
end
