class MessagesController < ApplicationController
  before_action :set_chat

  SYSTEM_PROMPT = <<~PROMPT
    You are a helpful assistant for gamers called Gamer's Oracle!
    You only help the user in the game of his choise! One per chat only!
    Answer in the same language as the user.
  PROMPT

  def create
    @message = @chat.messages.new(message_params)
    @message.role = "user"

    if @message.valid?
      response = @chat.with_instructions(SYSTEM_PROMPT).ask(@message.message)
      @chat.messages.create(role: "assistant", message: response.message)
      @chat.generate_title_from_first_message
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
