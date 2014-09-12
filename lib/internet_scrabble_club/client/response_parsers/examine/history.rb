require_relative '../examine'

module InternetScrabbleClub
  class Client
    module ResponseParsers

      class Examine::History < Examine
        rule(:sub_command) { str('HISTORY') }

        rule(:arguments) { delimited([stats, settings,
            (player_info.as(:info) >> newline_with_whitespace >> plays.as(:plays)
            ).as(:first_player), str('STOP'),
            (player_info.as(:info) >> newline_with_whitespace >> plays.as(:plays)
            ).as(:second_player), str('STOP')
          ], newline_with_whitespace) >> newline_with_whitespace }

        rule(:newline_with_whitespace) { space.repeat >> newline >> space.repeat }

        rule(:stats) { _int >> space >> date.as(:date) }
        rule(:settings) { delimited [int.as(:dictionary_code), _int, _int, _int] }

        rule(:player_info) { delimited [word.as(:nickname), int.as(:rating),
            rack.as(:initial_rack), (int | null).as(:final_score)] }

        rule(:plays) { ((move | change | pass) >> space?).repeat }

        rule(:move) { delimited [str('MOVE').as(:word).as(:type), position.as(:position),
            tiles.as(:word), int.as(:score), _int, _int, rack.as(:rack), _int] }

        rule(:change) { delimited [str('CHANGE').as(:word).as(:type), rack.as(:rack),
            _int, _int, (dashes | int).as(:swap_count)] }

        rule(:pass) { delimited [str('PAS').as(:word).as(:type), _int, _int, (dashes |
          suggestion).as(:suggestion)] }

        rule(:suggestion) { delimited [position.as(:position), word.as(:word),
          int.as(:score)], underscore }

        rule(:underscore) { match('_') }
        rule(:underscored_word) { word >> underscore >> word }

        rule(:position) { horizontal_position.as(:horizontal) |
          vertical_position.as(:vertical) }

        rule(:horizontal_position) { alpha.as(:word).as(:column) >> int.as(:row) }
        rule(:vertical_position) { int.as(:row) >> alpha.as(:word).as(:column) }
      end

    end
  end
end
