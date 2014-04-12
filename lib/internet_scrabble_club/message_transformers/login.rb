require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Login < Base
      rule(command: 'LOGIN', arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'LOGIN'}.merge(arguments))
      end
    end

  end
end
