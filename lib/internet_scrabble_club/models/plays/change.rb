require_relative './base'

module InternetScrabbleClub
  module Models
    module Plays

      class Change < Base
        property :rack, String
        property :swap_count, Integer
      end

    end
  end
end

