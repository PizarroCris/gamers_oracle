class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
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
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @game
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: "Game updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, notice: "Game deleted"
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :image)
  end
end
