require_relative 'base'
require_relative '../../messages/response/ping'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Examine < Base
        rule(command: 'EXAMINE', sub_command: simple(:sub_command), arguments: subtree(:arguments)) do
          Messages::Response::Examine.new(arguments.merge(type: sub_command))
        end
      end

    end
  end
end
