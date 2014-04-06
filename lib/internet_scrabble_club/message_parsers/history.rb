require_relative 'base'

module InternetScrabbleClub
  module MessageParsers

    class History < Base
      rule(:command) { str('HISTORY') }

      rule(:arguments) do
        seperated [nickname.as(:nickname), (entry >> space?).repeat(1).as(:entries)]
      end

      rule(:entry) do
        seperated [
          digit.as(:game_number),
          integer, nickname.as(:first_player), integer, nickname.as(:second_player),
          dictionary, minus.maybe >> integer, date.as(:date)
        ]
      end
    end

  end
end
