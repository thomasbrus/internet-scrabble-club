require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub

  class MessageParser < Parslet::Parser
    extend DescendantsTracker

    rule(:space) { match('\s') }
    rule(:space?) { space.maybe }

    rule(:colon) { str(':') }
    rule(:semicolon) { str(';') }
    rule(:minus) { str('-') }

    rule(:digit) { match['0-9'] }
    rule(:integer) { digit.repeat(1) }

    rule(:nickname) { match['A-Za-z0-9_-'].repeat(1, 10) }

    rule(:month_day) { digit.repeat(1, 2) }
    rule(:abbreviated_month) { match['A-Z'] >> match['a-z'].repeat(2, 2) }
    rule(:short_year) { digit >> digit }
    rule(:date) { seperated [month_day, abbreviated_month, short_year], colon  }

    rule(:dictionary) do
      str('TWL') | str('SOWPODS') | str('ODS') | str('LOC') |
      str('SWL') | str('PARO') | str('MULTI')
    end

    rule(:command_with_arguments) { self.class.descendants.map(&:new).reduce(:|) }
    root(:command_with_arguments)

    def seperated(sequence, seperator = space)
      seperators = Array.new(sequence.length - 1) { seperator }
      sequence.zip(seperators).flatten(1).compact.inject(:>>)
    end
  end

end
