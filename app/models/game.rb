# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players

  validates :field1, :field2, :field3, :field4, :field5,
            :field6, :field7, :field8, :field9,
            inclusion: { in: (Player::CHARACTERS + [nil]) }

  after_update :broadcast_tick_to_opponent

  def all_players_present?
    players.count == 2
  end

  private

  def broadcast_tick_to_opponent
    change = previous_changes.select { |k, _v| k.include?('field') }
    field = change.keys.first
    player = players.find_by(character: change[change.keys.first].last)

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
