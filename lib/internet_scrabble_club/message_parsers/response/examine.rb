require_relative 'base'

module InternetScrabbleClub
  module MessageParsers
    module Response

      class Examine < Base
        rule(:command) { str('EXAMINE') }
        rule(:sub_command) { str('HISTORY') | str('LIBRARY') | str('ADJOURNED') }

        rule(:arguments) { join([nothing, stats, settings,
            player_info.as(:first_player_info), plays.as(:first_player_plays), str('STOP'),
            player_info.as(:second_player_info), plays.as(:second_player_plays), str('STOP'),
            nothing ], newline_with_whitespace) }

        rule(:newline_with_whitespace) { space.repeat >> newline >> space.repeat }

        rule(:stats) { int >> space >> date.as(:date) }
        rule(:settings) { join [int, int, int, int.as(:dictionary_code)] }

        rule(:player_info) { join [word.as(:nickname), int.as(:rating),
            word.as(:initial_rack), int.as(:final_score)] }

        rule(:plays) { ((move | change | pass) >> space?).repeat }

        rule(:move) { join [str('MOVE').as(:type), position.as(:position),
            tiles.as(:word), int.as(:score), int, int, rack.as(:rack), int] }

        rule(:change) { join [str('CHANGE').as(:type), rack.as(:rack),
            int, int, int.as(:swap_count) | null] }

        rule(:pass) { join [str('PAS').as(:type), int, int, rack] }

        rule(:position) { horizontal_position.as(:horizontal) | vertical_position.as(:vertical) }
        rule(:horizontal_position) { alpha.as(:column) >> int.as(:row) }
        rule(:vertical_position) { int.as(:row) >> alpha.as(:column) }
      end

    end
  end
end
