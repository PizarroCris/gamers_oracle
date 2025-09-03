class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @chat = @game.chat
  end

  def new
    @games = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render  :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:name).permit(:name, :image)
  end
end
