require 'celluloid'

require_relative '../client'
require_relative '../db'
require_relative '../models/plays'
require_relative '../client/entity_extractors/examine/history'

module InternetScrabbleClub

  class Scraper

    class Games
      include Celluloid

      def initialize(nickname, password)
        @client = Client.new

        @game_requests_queue = players_without_games.reduce([]) do |queue, player|
          queue += (10.times.map do |game_number|
            ->(client, &callback) {
              client.send_request('EXAMINE', 'HISTORY', player.nickname, game_number, &callback)
            }
          end)
        end

        @client.authenticate(nickname, password) do |login|
          @game_requests_queue.shift.call(@client) do |examine_history_response|
            create_models_from_response(examine_history_response)
          end
        end
      end

      def create_models_from_response(response)
        create_dictionary_from_response(response)
        create_first_player_from_response(response)
        create_second_player_from_response(response)
        create_game_from_response(response)
        # TODO: Solve this in a more elegant way!
        create_plays_from_response(response) unless InternetScrabbleClub::Models::Game.last.plays.count > 0

        @game_requests_queue.shift.call(@client) do |examine_history_response|
          create_models_from_response(examine_history_response)
        end

        Celluloid::Logger.info("Created game! (count: #{InternetScrabbleClub::Models::Game.count})")
      end

      def create_dictionary_from_response(response)
        extract_dictionary_entity_from_response(response).save
      end

      def create_first_player_from_response(response)
        extract_first_player_entity_from_response(response).save
      end

      def create_second_player_from_response(response)
        extract_second_player_entity_from_response(response).save
      end

      def create_game_from_response(response)
        extract_game_entity_from_response(response).save
      end

      def create_plays_from_response(response)
        extract_play_models_from_response(response).each(&:save)
      end

      def extract_dictionary_entity_from_response(response)
        extract_models_from_response(response).dictionary
      end

      def extract_first_player_entity_from_response(response)
        extract_models_from_response(response).first_player
      end

      def extract_second_player_entity_from_response(response)
        extract_models_from_response(response).second_player
      end

      def extract_play_models_from_response(response)
        extract_models_from_response(response).plays
      end

      def extract_game_entity_from_response(response)
        extract_models_from_response(response).game
      end

      def extract_models_from_response(response)
        (@extracted_models ||= {})[response] ||= Client::EntityExtractors::Examine::History.new(response)
      end

      def players_without_games
        InternetScrabbleClub::Models::Player.all.select do |player|
          player.initiated_games.none? && player.accepted_games.none?
        end
      end
    end

  end
end
