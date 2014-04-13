require 'mongo_mapper'

module InternetScrabbleClub
  module Entities
    module Plays

      class Base
        include MongoMapper::Document
        belongs_to :game, class_name: 'InternetScrabbleClub::Entities::Game'
        one :player, class_name: 'InternetScrabbleClub::Entities::Player'
        key :index, Integer
      end

    end
  end
end
