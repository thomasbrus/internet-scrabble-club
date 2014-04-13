require_relative '../ping'

module InternetScrabbleClub
  module MessageParsers

    class Ping::Reply < Ping
      rule(:sub_command) { str('REPLY') }
    end

  end
end
