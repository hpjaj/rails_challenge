require "httparty"

module Oddball
  class Client
    include HTTParty
    base_uri 'efin.oddball.io'

    attr_reader :data, :user_id

    def initialize(data, user_id)
      @data = data
      @user_id = user_id
    end

    def check_health
      response = self.class.get("/health")

      response.body
    end

    def fetch_efin
      result   = "We experienced an issue fetching the EFIN. Please try again later."
      response = self.class.post("/", options)

      if response.code == 200
        result = efin_value_in(response)
      else
        Rails.logger.error "Experienced the following error when calling Oddball::Client.fetch_efin endpoint: #{response.parsed_response}"
      end

      ActionCable.server.broadcast(
        "efin:#{user_id}",
        { body: result }
      )
    end

  private

    def options
      {
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          "household": sanitize(data["household"]),
          "income":  sanitize(data["income"])
        }.to_json
      }
    end

    def efin_value_in(response)
      Hash.from_xml(response.body)["root"]["efin"].to_f
    end

    def sanitize(value_as_string)
      value_as_string.gsub(/\D/, '').to_i
    end
  end
end
