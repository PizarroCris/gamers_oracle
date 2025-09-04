class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :destroy, :ask_ai]

  def index
    @chats = current_user.chats.order(created_at: :desc)
  end

  def show
    @game     = @chat.game
    @messages = @chat.messages.order(:created_at)
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

  SYSTEM_PROMPT = "You are a helpful assistant for gamers."

  def ask_ai
    user_msg = params[:message].to_s.strip
    return redirect_to chat_path(@chat), alert: "Type a message first." if user_msg.blank?


    @chat.messages.create!(role: "user", message: user_msg)

    chat = RubyLLM.chat
    response = chat.with_instructions(SYSTEM_PROMPT).ask(user_msg)

    ai = response.content.presence || "I couldn't generate a reply."

    @chat.messages.create!(role: "assistant", message: ai)

    redirect_to chat_path(@chat)
  rescue RubyLLM::RateLimitError
    redirect_to chat_path(@chat), alert: "AI quota exceeded. Please try again later."
  rescue => e
    Rails.logger.error("ask_ai error: #{e.class}: #{e.message}")
    redirect_to chat_path(@chat), alert: "Robot error: #{e.message}"
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:game_id)
  end
end
