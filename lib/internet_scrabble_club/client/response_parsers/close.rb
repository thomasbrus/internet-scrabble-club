require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Close < Base
        rule(:command) { str('CLOSE') }
        rule(:arguments) { text.as(:reason) }
      end

    end
  end
end
