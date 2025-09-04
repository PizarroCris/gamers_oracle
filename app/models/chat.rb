class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :game
  belongs_to :user
  
  def generate_title_from_first_message
    title_prompt = <<~PROMPT
      Generate a short, descriptive, 3-to-6-word title that summarizes the user question for a chat conversation and include the game name #{self.game.name}
    PROMPT

    return unless title == "Untitled"

    first_user_message = messages.where(role: "user").order(:created_at).first
    return if first_user_message.nil?

    response = RubyLLM.chat.with_instructions(title_prompt).ask(first_user_message.content)
    update_column(:title, response.content)
  end
end
