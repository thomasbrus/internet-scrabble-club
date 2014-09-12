require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Unseek < Base
        rule(:command) { str('UNSEEK') }
        rule(:arguments) { word.as(:nickname) }
      end

    end
  end
end
