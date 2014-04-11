require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub
  module MessageParsers

    class Base < Parslet::Parser
      extend DescendantsTracker

      root(:message)

      rule(:message) { descendant_parsers.reduce(:|) or (digit >> space >>
        ( command_with_sub_command_and_arguments |
          command_with_arguments | command_with_sub_command)) }

      rule(:command_with_arguments) { command.as(:command) >> space >>
        arguments.as(:arguments) }

      rule(:command_with_sub_command_and_arguments) { command_with_sub_command >>
        space >> arguments.as(:arguments) }

      rule(:command_with_sub_command) { command.as(:command) >>
        space >> sub_command.as(:sub_command) }

      rule(:command) { nothing }
      rule(:sub_command) { nothing }
      rule(:arguments) { nothing }

      rule(:nothing) { str('') }

      rule(:space) { str(' ') }
      rule(:space?) { space.maybe }

      rule(:newline) { match('\n') }

      rule(:colon) { str(':') }
      rule(:semicolon) { str(';') }
      rule(:minus) { str('-') }

      rule(:digit) { match['0-9'] }
      rule(:alpha) { match['A-Za-z'] }
      rule(:int) { minus.maybe >> digit.repeat(1) }
      rule(:null) { str('---') }

      rule(:word) { (digit | alpha | match['_-']).repeat(1) }
      rule(:sentence) { match['^.'].repeat(1) >> str('.') }


      rule(:month_day) { digit.repeat(1, 2) }
      rule(:abbreviated_month) { match['A-Z'] >> match['a-z'].repeat(2, 2) }
      rule(:short_year) { digit >> digit }
      rule(:date) { seperated [month_day, abbreviated_month, short_year], colon  }

      rule(:dictionary) do
        str('TWL') | str('SOWPODS') | str('ODS') | str('LOC') |
        str('SWL') | str('PARO') | str('MULTI')
      end

      rule(:sentence) { match['^.'].repeat(1) >> str('.') }

      def join(sequence, seperator = space)
        seperators = Array.new(sequence.length - 1) { seperator }
        sequence.zip(seperators).flatten(1).compact.inject(:>>)
      end

      private def descendant_parsers
        @descendant_parsers ||= self.class.descendants.map(&:new)
      end
    end

  end
end
