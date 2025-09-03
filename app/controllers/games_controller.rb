class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @chat = @game.chat
  end
 
  def new
  end

  def create
  end

  private
  
  def article_params
    params.require(:game).permit(:name, :image)
  end
end
