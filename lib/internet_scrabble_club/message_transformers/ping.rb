require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Ping < Base
      rule(command: 'PING', sub_command: simple(:sub_command)) do
        OpenStruct.new(command: 'PING', action: sub_command)
      end
    end

  end
end
