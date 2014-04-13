require 'mongo_mapper'

module InternetScrabbleClub
  module Entities
    module Plays

      class Base
        include MongoMapper::Document
        belongs_to :game
      end

    end
  end
end
