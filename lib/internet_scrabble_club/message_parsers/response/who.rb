require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Who < Base
        rule(:command) { str('WHO') }

        rule(:arguments) do
          seperated [
            str('LIST'), (integer.as(:total) >> space), (user.as(:user) >> space?).repeat(1).as(:users)
          ]
        end

        rule(:user) do
          seperated [
            integer.as(:rating), nickname.as(:nickname), any.as(:status), digit, digit
          ]
        end
      end

    end
  end
end
