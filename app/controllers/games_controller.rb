class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @chats = @game.chats
  end

  def new
  end

  def create
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

end
