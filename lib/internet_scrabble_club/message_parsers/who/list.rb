require_relative '../who'

module InternetScrabbleClub
  module MessageParsers

    class Who::List < Who
      rule(:sub_command) { str('LIST') }
      rule(:arguments) { int.as(:count) >> space >> space >> users.as(:users) }
      rule(:users) { (user.as(:user) >> space?).repeat(1) }
      rule(:user) { join [int.as(:rating), word.as(:nickname), any.as(:status), digit, digit] }
    end

  end
end
