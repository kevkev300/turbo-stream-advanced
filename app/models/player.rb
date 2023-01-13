# frozen_string_literal: true

class Player < ApplicationRecord
  CHARACTERS = %w[X O].freeze

  belongs_to :game

  before_create :assign_character

  validates :name, presence: true

  private

  def assign_character
    self.character = (Player::CHARACTERS - game.players.pluck(:character)).sample
  end
end
