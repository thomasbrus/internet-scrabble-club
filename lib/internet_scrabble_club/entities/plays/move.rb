require 'mongo_mapper'
require_relative 'base'

module InternetScrabbleClub
  module Entities
    module Plays

      class Move < Base
        key :position, Hash
        key :word, String
        key :score, Integer
        key :rack, String
      end

    end
  end
end
