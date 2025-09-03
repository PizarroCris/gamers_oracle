class ChatsController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @chat = @game.chat
  end



end
