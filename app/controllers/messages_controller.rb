class MessagesController < ApplicationController
  before_action :set_chat

  SYSTEM_PROMPT = <<~PROMPT
    You are a helpful assistant for gamers called Gamer's Oracle!
    You only help the user in the game of his choise! One per chat only!
    Answer in the same language as the user.
  PROMPT

  def create
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.valid?
      @chat.with_instructions(instructions(@chat.game.name)).ask(@message.content)
      @chat.generate_title_from_first_message
      redirect_to chat_path(@chat)
    else
      @chat.reload
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def instructions(game)
    [SYSTEM_PROMPT, "the game is #{game}"]
    .compact.join("\n\n")
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
