require 'ostruct'
require_relative '../examine'

module InternetScrabbleClub
  class MessageTransformers

    class Examine::History < Examine
      rule(date: simple(:date), dictionary_code: simple(:dictionary_code),
        first_player: subtree(:first_player), second_player: subtree(:second_player)
      ) do
        { date: date, dictionary_code: dictionary_code,
          first_player: first_player, second_player: second_player
        }
      end

      rule(setup: subtree(:setup), plays: subtree(:plays)) do
        OpenStruct.new(setup: setup, plays: plays.map { |play| OpenStruct.new(play) })
      end

      rule(horizontal: { column: simple(:column), row: simple(:row) }) do
        OpenStruct.new(direction: :horizontal, column: column, row: row)
      end

      rule(vertical: { column: simple(:column), row: simple(:row) }) do
        OpenStruct.new(direction: :vertical, column: column, row: row)
      end
    end

  end
end