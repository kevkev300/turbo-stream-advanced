# frozen_string_literal: true

module ApplicationHelper
  def show_character(game, player, field_nr)
    winning_fields = game.winner_fields(player.character)
    loosing_fields = game.winner_fields(player.opponent.character)

    bg_class = if winning_fields&.include?(field_nr)
                '!bg-green-500'
               elsif loosing_fields&.include?(field_nr)
                '!bg-red-500'
               end

    tag.text(game.public_send("field#{field_nr}_character"), class: bg_class)
  end
end
