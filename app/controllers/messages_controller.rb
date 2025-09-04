class MessagesController < ApplicationController
  before_action :set_chat

  SYSTEM_PROMPT = <<~PROMPT
    You are a helpful assistant for gamers called Gamer's Oracle!

    Help the user explore knowledge, strategies, secrets, and curiosities about the game related to this chat.

  PROMPT

  def create
    user_message = params[:message].to_s.strip
    if user_message.blank?
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.update("messages_alert", "Type a message first.") }
        format.html { redirect_to chat_path(@chat), alert: "Type a message first." }
      end
      return
    end

    @chat.messages.create!(role: "user", message: user_message)

    prompt_with_language = SYSTEM_PROMPT + "\nRespond in #{I18n.locale}."

    begin
      chat_ai = RubyLLM.chat
      response = chat_ai.with_instructions(prompt_with_language).ask(user_message)
      ai_response = response.content.presence || "I couldn't generate a reply."
      @chat.messages.create!(role: "assistant", message: ai_response)
    rescue RubyLLM::RateLimitError
      flash.now[:alert] = "AI quota exceeded. Please try again later."
    rescue => e
      Rails.logger.error("Messages#create AI error: #{e.class} - #{e.message}")
      flash.now[:alert] = "AI error: #{e.message}"
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
