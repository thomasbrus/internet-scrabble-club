require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class History < Base
      rule(command: 'HISTORY', arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'HISTORY'}.merge(arguments))
      end

      rule(entry: subtree(:entry)) do
        OpenStruct.new(entry)
      end

      rule({ index: simple(:index), first_player: simple(:first_player),
        second_player: simple(:second_player), date: simple(:date)
      }) do
        { index: Integer(index), first_player: first_player.to_s,
          second_player: second_player.to_s, date: Date.parse(date.to_s) }
      end
    end

  end
end
