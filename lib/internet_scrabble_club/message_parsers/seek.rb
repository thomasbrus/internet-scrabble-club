require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Seek < Base
      rule(:command) { str('SEEK') }
      rule(:arguments) { join [int.as(:rating), word.as(:nickname), settings] }
      rule(:settings) { join 7 * [_int] }
    end

  end
end
