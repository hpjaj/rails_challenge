require 'securerandom'

class EfinChannel < ApplicationCable::Channel
  def subscribed
    stream_from "efin:#{current_user.id}"
  end

  def receive(data)
    ActionCable.server.broadcast "efin:#{current_user.id}", { body: "fetching..." }

    EfinJob.perform_now(data, current_user.id)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
