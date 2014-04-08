require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Request

      class History < Messages::Base
        def initialize(nickname)
          @nickname = nickname
        end

        def arguments
          [@nickname]
        end
      end

    end
  end
end
