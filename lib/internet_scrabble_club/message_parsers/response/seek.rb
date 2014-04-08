require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Seek < Base
        rule(:command) { str('SEEK') }

        rule(:arguments) do
          seperated [integer.as(:rating), nickname.as(:nickname)] + [integer] * 7
        end
      end

    end
  end
end
