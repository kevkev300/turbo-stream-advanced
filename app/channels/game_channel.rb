# frozen_string_literal: true

class GameChannel < ApplicationCable::Channel
  extend Turbo::Streams::StreamName
  extend Turbo::Streams::Broadcasts
  include Turbo::Streams::StreamName::ClassMethods

  def subscribed
    stream_name = verified_stream_name_from_params
    if stream_name.present?
      stream_from stream_name
    else
      reject
    end
  end

  def unsubscribed
    return if subscription_rejected?

    current_player.broadcast_unsubsciption
  end
end
