require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Seek < Base
      rule(command: 'SEEK', arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'SEEK'}.merge(arguments))
      end
    end

  end
end
