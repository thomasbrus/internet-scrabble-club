require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Ping < Base
      rule(:command) { str('PING') }
      rule(:sub_command) { str('REPLY') }
    end

  end
end
