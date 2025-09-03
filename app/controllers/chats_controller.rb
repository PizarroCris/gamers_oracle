class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end
  
  def show
    @game = Game.find(params[:id])
    @chat = @game.chat
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

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to chats_path, notice: "Chat deleted"
  end

  private

  def chat_params
    params.require(:chat).permit(:game_id)
  end
end
