require 'data_mapper'
require 'dm-validations'

module InternetScrabbleClub
  module Models

    class Game
      include DataMapper::Resource

      property :id, Serial
      property :date, Date, required: true

      belongs_to :dictionary, 'InternetScrabbleClub::Models::Dictionary'
      belongs_to :first_player, 'InternetScrabbleClub::Models::Player'
      belongs_to :second_player, 'InternetScrabbleClub::Models::Player'

      has n, :plays, 'InternetScrabbleClub::Models::Plays::Base'

      property :first_player_final_score, Integer, required: true
      property :second_player_final_score, Integer, required: true

      property :first_player_initial_rack, String, required: true
      property :second_player_initial_rack, String, required: true

      def winner?
        !tie? && finished?
      end

      def tie?
        first_player_final_score == second_player_final_score
      end

      def finished?
        !(first_player_final_score == -1 || second_player_final_score == -1)
      end

      alias_method :to_s, :inspect
    end

  end
end
