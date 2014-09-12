require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Who < Base
        rule(:command) { str('WHO') }
      end

    end
  end
end
