require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Examine < Base
      rule(command: 'EXAMINE', sub_command: simple(:sub_command), arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'EXAMINE', type: sub_command}.merge(arguments))
      end
    end

  end
end
