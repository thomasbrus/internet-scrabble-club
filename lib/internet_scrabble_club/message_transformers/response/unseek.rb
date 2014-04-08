require_relative 'base'
require_relative '../../messages/response/unseek'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Unseek < Base
        rule(command: 'UNSEEK', arguments: subtree(:arguments)) do
          Messages::Response::Unseek.new(arguments)
        end
      end

    end
  end
end
