require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub
  module MessageParsers

    class Base < Parslet::Parser
      extend DescendantsTracker

      root(:command_with_arguments)

      rule(:command_with_arguments) do
        (self.class.descendants.map(&:new).reduce(:|)) or
        (prefix >> command.as(:command) >> space >> arguments.as(:arguments))
      end

      rule(:space) { match('\s') }
      rule(:space?) { space.maybe }

      rule(:prefix) { str('0 ') }

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

      def seperated(sequence, seperator = space)
        seperators = Array.new(sequence.length - 1) { seperator }
        sequence.zip(seperators).flatten(1).compact.inject(:>>)
      end
    end

  end
end
