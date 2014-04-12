require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class Examine < Base
      rule(command: 'EXAMINE', sub_command: simple(:sub_command), arguments: subtree(:arguments)) do
        OpenStruct.new({command: 'EXAMINE', type: sub_command}.merge(arguments))
      end

      rule({ date: simple(:date), dictionary_code: simple(:dictionary_code),
        first_player_info: subtree(:first_player_info),
        first_player_plays: subtree(:first_player_plays),
        second_player_info: subtree(:second_player_info),
        second_player_plays: subtree(:second_player_plays)
      }) do
        { date: Date.parse(date.to_s), dictionary_code: dictionary_code,
          first_player: OpenStruct.new(first_player_info),
          second_player: OpenStruct.new(second_player_info),
          plays: first_player_plays.zip(second_player_plays).flatten(1),
        }
      end

      rule(horizontal: { column: simple(:column), row: simple(:row) }) do
        OpenStruct.new(direction: :horizontal, column: column, row: row)
      end

      rule(vertical: { column: simple(:column), row: simple(:row) }) do
        OpenStruct.new(direction: :vertical, column: column, row: row)
      end

      rule({ type: 'MOVE', position: simple(:position), word: simple(:word),
        score: simple(:score), rack: simple(:rack)
      }) do
        OpenStruct.new({ type: :move, position: position, word: word.to_s,
          score: Integer(score), rack: rack.to_s })
      end

      rule(type: 'PAS') do
        OpenStruct.new(type: :pass)
      end

      rule(type: 'CHANGE', rack: simple(:rack), swap_count: simple(:swap_count)) do
        OpenStruct.new(type: :change, rack: rack.to_s, swap_count: Integer(swap_count))
      end
    end
  end
end
