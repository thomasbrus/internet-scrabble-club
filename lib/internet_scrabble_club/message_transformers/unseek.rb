require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Unseek < Base
      rule(command: 'UNSEEK', arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'UNSEEK'}.merge(arguments))
      end
    end

  end
end
