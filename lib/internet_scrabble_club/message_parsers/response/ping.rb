require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Ping < Base
        rule(:command) { str('PING') }
        rule(:arguments) { str('REPLY').as(:action) }
      end

    end
  end
end
