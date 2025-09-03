class GamesController < ApplicationController
  def index
    @games = [
      OpenStruct.new(
        game: OpenStruct.new(name: "The Legend of Zelda: Breath of the Wild"),
        image: OpenStruct.new(key: "https://placehold.co/300x400?text=Zelda")
      ),
      OpenStruct.new(
        game: OpenStruct.new(name: "Elden Ring"),
        image: OpenStruct.new(key: "https://placehold.co/300x400?text=Elden+Ring")
      ),
      OpenStruct.new(
        game: OpenStruct.new(name: "God of War Ragnarok"),
        image: OpenStruct.new(key: "https://placehold.co/300x400?text=God+of+War")
      ),
      OpenStruct.new(
        game: OpenStruct.new(name: "Red Dead Redemption 2"),
        image: OpenStruct.new(key: "https://placehold.co/300x400?text=RDR2")
      )
    ]
  end
end
