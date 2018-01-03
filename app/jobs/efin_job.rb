class EfinJob < ApplicationJob
  queue_as :default

  def perform(data, user_id)
    Oddball::Client.new(data, user_id).fetch_efin
  end
end
