require 'mongo_mapper'

module InternetScrabbleClub
  module Entities

    class Game
      include MongoMapper::Document

      key :date, Date
      key :dictionary_code,  String
      key :initial_racks, Array
      key :final_scores, Array

      many :plays, class_name: 'InternetScrabbleClub::Entities::Plays::Base'
      many :players, class_name: 'InternetScrabbleClub::Entities::Player'
    end

  end
end
