class Message < ApplicationRecord
  acts_as_message

  validates :content, length: { minimum: 3, maximum: 1000 }, if: -> { role == "user" }
  validates :role, presence: true
  validates :chat, presence: true

  MAX_USER_MESSAGES = 10
  validate :user_message_limit, if: -> { role == "user" }

  after_create_commit :broadcast_append_to_chat
  

  private

  def broadcast_append_to_chat
    return unless role.in?(["user", "assistant"])

    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self }
  end

  def user_message_limit
    if chat.messages.where(role: "user").count >= MAX_USER_MESSAGES
      errors.add(:base, "You can only send #{MAX_USER_MESSAGES} messages per chat.")
    end
  end
end
