require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Request

      class Login < Messages::Base
        def initialize(nickname, password)
          @nickname, @password = nickname, password
        end

        def arguments
          [@nickname, @password, 1871, 'HVyHL.YxgQs0EtEtYYQ2uuEm?icRMu0']
        end
      end

    end
  end
end
