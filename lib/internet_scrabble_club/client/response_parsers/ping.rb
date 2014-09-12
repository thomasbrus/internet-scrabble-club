require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Ping < Base
        rule(:command) { str('PING') }
      end

    end
  end
end
