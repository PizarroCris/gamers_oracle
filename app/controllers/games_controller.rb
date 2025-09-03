class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @chats = @game.chats
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :image)
  end

  private
  
  def game_params
    params.require(:game).permit(:name, :image)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
