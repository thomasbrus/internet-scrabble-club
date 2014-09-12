require 'data_mapper'
require 'dm-validations'

module InternetScrabbleClub
  module Models

    class Player
      include DataMapper::Resource

      property :id, Serial
      property :nickname, String, required: true
      property :rating, Integer

      has n, :initiated_games, 'InternetScrabbleClub::Models::Game', child_key: [:first_player_id]
      has n, :accepted_games, 'InternetScrabbleClub::Models::Game', child_key: [:second_player_id]

      alias_method :to_s, :inspect
    end

  end
end
