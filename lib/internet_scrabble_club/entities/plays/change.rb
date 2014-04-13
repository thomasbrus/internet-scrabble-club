require 'mongo_mapper'
require_relative 'base'

module InternetScrabbleClub
  module Entities
    module Plays

      class Change < Base        
        key :rack, String
        key :swap_count, Integer
      end

    end
  end
end
