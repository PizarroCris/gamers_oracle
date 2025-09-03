class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :destroy, :ask_ai]

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

  def ask_ai
    user_msg = params[:message].to_s.strip

    if user_msg.blank?
      redirect_to chat_path(@chat), alert: "Type a message first." and return
    end

    # Save user's message
    @chat.messages.create!(role: "user", content: user_msg)

    client = RubyLLM::OpenAI.new
    response = client.chat(
      messages: build_thread(@chat),   # include history
      model: "gpt-4o-mini"
    )

    ai_reply = response.dig("choices", 0, "message", "content") || "I couldn't generate a reply."
    @chat.messages.create!(role: "assistant", content: ai_reply)

    redirect_to chat_path(@chat)
  rescue => e
    Rails.logger.error("ask_ai error: #{e.class}: #{e.message}")
    redirect_to chat_path(@chat), alert: "Robot error: #{e.message}"
  end

  private

  def set_chat
    # 🔒 ensures users only access their own chat
    @chat = current_user.chats.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:game_id)
  end

  # Build the full conversation as OpenAI messages
  def build_thread(chat)
    base = [{ role: "system", content: "You are a helpful assistant for gamers." }]
    msgs = chat.messages.order(:created_at).pluck(:role, :content).map { |r, c| { role: r, content: c } }
    base + msgs
  end
end
