require_relative 'base'
require_relative '../../messages/response/ping'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Ping < Base
        rule(command: 'PING', arguments: subtree(:arguments)) do
          Messages::Response::Ping.new(arguments)
        end
      end

    end
  end
end
