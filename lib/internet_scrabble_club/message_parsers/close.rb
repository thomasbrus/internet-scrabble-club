require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Close < Base
      rule(:command) { str('CLOSE') }
      rule(:arguments) { text.as(:reason) }
    end

  end
end
