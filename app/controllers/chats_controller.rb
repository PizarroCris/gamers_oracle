class ChatsController < ApplicationController
  before_action :authenticate_user!                # if using Devise
  before_action :set_chat, only: [:show, :destroy]

  def index
    @chats = current_user.chats.order(created_at: :desc)
  end

  def show
    @game = @chat.game
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
    @chat.destroy
    redirect_to chats_path, notice: "Chat deleted"
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:id])   # ensures users only see their chats
  end

  def chat_params
    params.require(:chat).permit(:game_id)
  end
end
