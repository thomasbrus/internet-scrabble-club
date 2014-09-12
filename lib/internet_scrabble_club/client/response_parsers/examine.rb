require_relative 'base'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Examine < Base
        rule(:command) { str('EXAMINE') }
        rule(:command_with_sub_command_and_arguments) { command_with_sub_command >>
          space? >> newline >> arguments.as(:arguments) }
      end

    end
  end
end
