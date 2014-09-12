require_relative './base'

module InternetScrabbleClub
  module Models
    module Plays

      class Pass < Base
        property :suggestion, Text
      end

    end
  end
end

