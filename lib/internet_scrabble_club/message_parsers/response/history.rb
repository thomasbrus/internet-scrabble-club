require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class History < Base
        rule(:command) { str('HISTORY') }
        rule(:arguments) { nickname.as(:subject) >> space >> entries.as(:entries) }
        rule(:entries) { (entry.as(:entry) >> space?).repeat(1) }
        rule(:entry) { join [digit.as(:index), players, dictionary, int, date.as(:date)] }
        rule(:players) { join [int, nickname.as(:first_player), int, nickname.as(:second_player)] }
      end

    end
  end
end
