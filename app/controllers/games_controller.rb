class GamesController < ApplicationController
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
