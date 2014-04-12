require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Unseek < Base
      rule(:command) { str('UNSEEK') }
      rule(:arguments) { word.as(:nickname) }
    end

  end
end
