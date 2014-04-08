require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Request

      class Ping < Messages::Base
        def initialize(action)
          @action = action
        end

        def arguments
          [@action]
        end
      end

    end
  end
end
