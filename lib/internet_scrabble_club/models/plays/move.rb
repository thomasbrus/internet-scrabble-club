require_relative './base'

module InternetScrabbleClub
  module Models
    module Plays

      class Move < Base
        property :direction, String
        property :column, String
        property :row, Integer
        property :word, String
        property :score, Integer
        property :rack, String
      end

    end
  end
end


