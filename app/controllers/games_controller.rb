# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    unless player
      flash[:alert] = 'You first need to sign up as a player for this game'
      redirect_to new_game_player_path(game)
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new

    if @game.save
      redirect_to new_game_player_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @player = game.players.find(games_params[:player_id])
    game.update("field#{games_params[:field_nr]}": @player.id)

    render partial: 'own_tick', locals: {
      game: game,
      player: @player,
      field_nr: games_params[:field_nr]
    }
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end

  def player
    @player ||= game.players.find_by(id: params[:player_id])
  end

  def games_params
    params.require(:game).permit(:field_nr, :player_id)
  end

  def field_value(player)
    @player.character
  end
end
