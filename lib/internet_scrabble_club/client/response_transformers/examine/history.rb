require 'ostruct'
require_relative '../base'

module InternetScrabbleClub
  class Client
    class ResponseTransformers
      module Examine

        class History < Base
          rule(horizontal: { column: simple(:column), row: simple(:row) }) do
            {direction: :horizontal, column: column, row: row}
          end

          rule(vertical: { column: simple(:column), row: simple(:row) }) do
            {direction: :vertical, column: column, row: row}
          end
        end

      end
    end
  end
end
