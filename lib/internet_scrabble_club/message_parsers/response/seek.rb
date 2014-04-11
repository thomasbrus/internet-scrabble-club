require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Seek < Base
        rule(:command) { str('SEEK') }
        rule(:arguments) { join [int.as(:rating), word.as(:nickname), settings] }
        rule(:settings) { join [int, int, int, int, int, int, int] }
      end

    end
  end
end
