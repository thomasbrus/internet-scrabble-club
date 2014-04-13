require_relative '../who'

module InternetScrabbleClub
  module MessageParsers

    class Who::Move< Who
      rule(:sub_command) { str('MOVE') }
      rule(:arguments) { delimited [_int, word.as(:nickname), alpha, _int, _int] }
    end

  end
end
