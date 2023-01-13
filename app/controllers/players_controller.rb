# frozen_string_literal: true

class PlayersController < ApplicationController
  def new
    @player = Player.new(game: game)
  end

  def create
    @player = game.players.new(player_params)

    if @player.save
      redirect_to game_path(@player.game, player_id: @player.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
