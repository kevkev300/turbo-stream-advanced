# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players

  after_update :broadcast_tick_to_opponent

  def all_players_present?
    characters = players.pluck(:character)
    Player::CHARACTERS.all? { |c| characters.include?(c) }
  end

  (1..9).each do |i|
    define_method("field#{i}_player") do
      players.find_by(id: send("field#{i}"))
    end

    define_method("field#{i}_character") do
      send("field#{i}_player")&.character
    end
  end

  private

  def broadcast_tick_to_opponent
    change = previous_changes.select { |k, _v| k.include?('field') }
    return if change.empty?

    field = change.keys.first
    player = players.find_by(id: change[change.keys.first].last)

    broadcast_replace_to [player.opponent, 'board'],
                        target: field,
                        partial: 'games/opponent_tick',
                        locals: {
                          game: self,
                          player: player.opponent,
                          field_nr: field.last
                        }
  end
end
