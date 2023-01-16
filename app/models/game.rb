# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players

  validates :field1, :field2, :field3, :field4, :field5,
            :field6, :field7, :field8, :field9,
            inclusion: { in: (Player::CHARACTERS + [nil]) }

  def all_players_present?
    players.count == 2
  end
end
