require_relative 'base'
require_relative '../../messages/response/login'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class Login < Base
        rule(command: 'LOGIN', arguments: subtree(:arguments)) do
          Messages::Response::Login.new(arguments)
        end
      end

    end
  end
end
