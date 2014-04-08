require_relative 'base'
require_relative '../../messages/response/seek'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Seek < Base
        rule(command: 'SEEK', arguments: subtree(:arguments)) do
          Messages::Response::Seek.new(arguments)
        end
      end

    end
  end
end
