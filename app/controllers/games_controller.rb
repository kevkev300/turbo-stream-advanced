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

  private

  def game
    @game ||= Game.find(params[:id])
  end

  def player
    @player ||= game.players.find_by(id: params[:player_id])
  end
end
