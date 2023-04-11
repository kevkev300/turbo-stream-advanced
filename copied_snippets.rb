# --- turbo-rails gem
# app/models/concerns/turbo/broadcastable.rb
module Turbo::Broadcastable
  extend ActiveSupport::Concern

  module ClassMethods

    def broadcast_remove_to # arguments
      # code
    end

    def broadcast_update_to # arguments
      # code
    end

    # even more methods
  end
end

# lib/turbo/engine.rb
initializer "turbo.broadcastable" do
  ActiveSupport.on_load(:active_record) do
    include Turbo::Broadcastable
  end
end
