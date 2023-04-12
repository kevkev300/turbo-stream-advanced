# frozen_string_literal: true

class Player < ApplicationRecord
  CHARACTERS = %w[⚔️ 🐉].freeze

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
    self.character = case game.players.count
                     when 0 then Player::CHARACTERS.first
                     when 1 then Player::CHARACTERS.last
                     end

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
