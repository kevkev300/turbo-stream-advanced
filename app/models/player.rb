# frozen_string_literal: true

class Player < ApplicationRecord
  CHARACTERS = %w[X O].freeze

  belongs_to :game

  before_create :assign_character

  validates :name, presence: true

  after_create :notify_opponent

  def opponent
    opponent_character = (CHARACTERS - [character]).first
    game.players.find_by(character: opponent_character)
  end

  private

  def assign_character
    self.character = (Player::CHARACTERS - game.players.pluck(:character)).sample
  end

  def notify_opponent
    return if opponent.nil?

    broadcast_update_to [opponent, 'board'],
                         target: 'board',
                         partial: 'games/board',
                         locals: { game: game, player: opponent }

    broadcast_update_to [opponent, 'board'],
                        target: 'opponent_name',
                        partial: 'games/opponent_name',
                        locals: { opponent: self }
  end
end
