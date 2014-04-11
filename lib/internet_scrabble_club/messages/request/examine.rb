require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Request

      class Examine < Messages::Base
        def initialize(type, nickname, index)
          @type, @nickname, @index = type, nickname, index
        end

        def arguments
          [@type, @nickname, @index]
        end
      end

    end
  end
end
