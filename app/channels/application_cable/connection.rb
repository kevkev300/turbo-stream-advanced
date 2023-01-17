module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = Player.find_by(id: cookies['player_id'])
      reject_unauthorized_connection unless current_player.character
    end
  end
end
