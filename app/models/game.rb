# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players

  def all_players_present?
    players.count == 2
  end
end
