require_relative 'base'
require_relative '../../messages/response/history'
require_relative '../../messages/response/history/entry'

module InternetScrabbleClub
  class MessageTransformers
    module Response

      class History < Base
        rule(command: 'HISTORY', arguments: subtree(:arguments)) do
          Messages::Response::History.new(arguments)
        end

        rule(entry: subtree(:entry)) do
          Messages::Response::History::Entry.new(
            index: entry[:index],
            date: entry[:date],
            players: [entry[:first_player], entry[:second_player]]
          )
        end
      end

    end
  end
end
