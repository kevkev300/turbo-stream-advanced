# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players

  WINNING_FIELDS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

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

  def winner_fields(character)
    fields = WINNING_FIELDS.select do |fields|
      fields.all? { |f| send("field#{f}_character") == character }
    end.flatten

    fields.empty? ? nil : fields
  end

  private

  def broadcast_tick_to_opponent
    change = previous_changes.select { |k, _v| k.include?('field') }
    return if change.empty?

    field = change.keys.first
    player = players.find_by(id: change[change.keys.first].last)

    if winner_fields(player.character)
      broadcast_replace_to [player.opponent, 'board'],
      target: 'board',
      partial: 'games/board',
      locals: {
        game: self,
        player: player.opponent,
      }
    else
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
end
