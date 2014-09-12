require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Login < Base
        rule(:command) { str('LOGIN') }
        rule(:arguments) { sentence.as(:greeting) }
      end

    end
  end
end
