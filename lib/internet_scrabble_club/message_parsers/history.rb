require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class History < Base
      rule(:command) { str('HISTORY') }
      rule(:arguments) { word.as(:subject) >> space >> entries.as(:entries) }
      rule(:entries) { (entry.as(:entry) >> space?).repeat(1) }
      rule(:entry) { join [digit.as(:index), players, dictionary, int, date.as(:date)] }
      rule(:players) { join [int, word.as(:first_player), int, word.as(:second_player)] }
    end

  end
end
