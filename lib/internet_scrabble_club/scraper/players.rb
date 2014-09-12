require 'celluloid'

require_relative '../client'
require_relative '../db'
require_relative '../models/plays'
require_relative '../client/entity_extractors/examine/history'

module InternetScrabbleClub

  class Scraper

    class Players
      include Celluloid

      prepend (Module.new {
        def create_player_from_response(response)
          player = super; Celluloid::Logger.info("Created player: #{player}")
        end
      })

      def initialize(nickname, password)
        @client = Client.new
        @client.authenticate(nickname, password)
        @client.on_response(/^(UN)SEEK$/) { |r| create_player_from_response(r) }
      end

      private

      def create_player_from_response(response)
        InternetScrabbleClub::Models::Player.first_or_create(
          { nickname: response.fetch(:nickname) },
          { nickname: response.fetch(:nickname), rating: response.fetch(:rating, nil) }
        )
      end
    end

  end
end
