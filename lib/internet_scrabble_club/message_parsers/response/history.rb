require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class History < Base
        rule(:command) { str('HISTORY') }

        rule(:arguments) do
          nickname.as(:subject) >> space >> (entry.as(:entry) >> space?).repeat(1).as(:entries)
        end

        rule(:entry) do
          seperated [
            digit.as(:index),
            integer, nickname.as(:first_player), integer, nickname.as(:second_player),
            dictionary, minus.maybe >> integer, date.as(:date)
          ]
        end
      end

    end
  end
end
