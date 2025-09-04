class Message < ApplicationRecord
  acts_as_message

  validates :message, length: { minimum: 10, maximum: 1000 }, if: -> { role == "user" }
  validates :role, presence: true
  validates :chat, presence: true

  MAX_USER_MESSAGES = 10
  validate :user_message_limit, if: -> { role == "user" }

  private

  def user_message_limit
    if chat.messages.where(role: "user").count >= MAX_USER_MESSAGES
      errors.add(:base, "You can only send #{MAX_USER_MESSAGES} messages per chat.")
    end
  end
end
