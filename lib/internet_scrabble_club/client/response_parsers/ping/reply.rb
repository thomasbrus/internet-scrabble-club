require_relative '../ping'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Ping::Reply < Ping
        rule(:sub_command) { str('REPLY') }
      end
    end
  end
end
