require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Login < Base
        rule(:command) { str('LOGIN') }
        rule(:arguments) { sentence.as(:greeting) }
      end

    end
  end
end
