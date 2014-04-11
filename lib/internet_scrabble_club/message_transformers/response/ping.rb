require_relative 'base'
require_relative '../../messages/response/ping'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Ping < Base
        rule(command: 'PING', sub_command: simple(:sub_command)) do
          Messages::Response::Ping.new(action: sub_command)
        end
      end

    end
  end
end
