require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class History < Base
        rule(:command) { str('HISTORY') }
        rule(:arguments) { word.as(:subject) >> space >> entries.as(:entries) }
        rule(:entries) { (entry.as(:entry) >> space?).repeat(1) }
        rule(:entry) { delimited [digit.as(:index), players, dictionary, _int, date.as(:date)] }
        rule(:players) { delimited [_int, word.as(:first_player), _int, word.as(:second_player)] }
      end

    end
  end
end
