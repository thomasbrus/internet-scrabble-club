require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Ping < Base
      rule(:command) { str('PING') }
    end

  end
end
