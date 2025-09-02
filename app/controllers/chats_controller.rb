class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: "Chat created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:game_id)
  end
end
