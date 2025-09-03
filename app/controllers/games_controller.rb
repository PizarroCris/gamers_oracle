class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @chat = @game.chat
  end
 
  def new
  end

  def create
  end
end
