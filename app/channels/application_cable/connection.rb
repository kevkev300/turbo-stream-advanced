module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      player = Player.find_by(id: cookies['player_id'])
      reject_unauthorized_connection unless player.character
    end
  end
end
