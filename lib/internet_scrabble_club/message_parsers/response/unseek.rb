require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Unseek < Base
        rule(:command) { str('UNSEEK') }
        rule(:arguments) { nickname.as(:nickname) }
      end

    end
  end
end
