require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class Who < Base
      rule(:command) { str('WHO') }
    end

  end
end
