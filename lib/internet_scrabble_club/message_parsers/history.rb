require_relative '../message_parser'

module InternetScrabbleClub
  module MessageParsers

    class History < MessageParser
      rule(:command) { str('HISTORY') }

      rule(:entry) do
        seperated [
          digit.as(:game_number),
          integer, nickname.as(:first_player), integer, nickname.as(:second_player),
          dictionary, minus.maybe >> integer, date.as(:date)
        ]
      end

      rule(:command_with_arguments) do
        seperated [
          command, nickname.as(:nickname), (entry >> space?).repeat(1).as(:entries)
        ]
      end

      root(:command_with_arguments)
    end

  end
end
