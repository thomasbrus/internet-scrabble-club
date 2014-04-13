require 'mongo_mapper'

module InternetScrabbleClub
  module Entities

    class Player
      include MongoMapper::EmbeddedDocument

      key :nickname, String
      key :rating, Integer
    end

  end
end
