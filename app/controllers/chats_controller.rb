class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:game_id].present?
      @game = Game.find(params[:game_id])
      @chats = current_user.chats.where(game: @game)
    else
      @chats = current_user.chats.all
      @game = nil
    end
    @chat = Chat.new
  end

  def show
    @chat = Chat.includes(:messages).find(params[:id])
    @message = Message.new

    if Rails.env.development?
      @input_tokens = @chat.messages.pluck(:input_tokens).compact.sum
      @output_tokens = @chat.messages.pluck(:output_tokens).compact.sum

      last_model_id = @chat.messages.last&.model_id
      @context_window = last_model_id ? RubyLLM.models.find(last_model_id).context_window : nil
    end
  end

  def new
    @chat = Chat.new
    @available_games = Game.left_outer_joins(:chats).where(chats: { id: nil })
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
end
