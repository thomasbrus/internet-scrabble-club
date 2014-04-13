require 'mongo_mapper'
require_relative 'base'

module InternetScrabbleClub
  module Entities
    module Plays

      class Pass < Base
        key :suggestion, Hash
      end

    end
  end
end
