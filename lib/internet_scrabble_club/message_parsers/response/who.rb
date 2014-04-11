require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Who < Base
        rule(:command) { str('WHO') }
        rule(:sub_command) { str('LIST') }
        rule(:arguments) { int.as(:count) >> space >> space >> users.as(:users) }
        rule(:users) { (user.as(:user) >> space?).repeat(1) }
        rule(:user) { join [int.as(:rating), word.as(:nickname), any.as(:status), digit, digit] }
      end

    end
  end
end
