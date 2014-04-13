require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Seek < Base
      rule(:command) { str('SEEK') }
      rule(:arguments) { delimited [int.as(:rating), word.as(:nickname), settings] }
      rule(:settings) { delimited([_int] * 7) }
    end

  end
end
