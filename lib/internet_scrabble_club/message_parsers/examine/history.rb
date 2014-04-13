require_relative '../examine'

module InternetScrabbleClub
  module MessageParsers

    class Examine::History < Examine
      rule(:sub_command) { str('HISTORY') }

      rule(:arguments) { join([stats, settings,
          (player_setup.as(:setup) >> newline_with_whitespace >> plays.as(:plays)
          ).as(:first_player), str('STOP'),
          (player_setup.as(:setup) >> newline_with_whitespace >> plays.as(:plays)
          ).as(:second_player), str('STOP')
        ], newline_with_whitespace) >> newline_with_whitespace }

      rule(:newline_with_whitespace) { space.repeat >> newline >> space.repeat }

      rule(:stats) { _int >> space >> date.as(:date) }
      rule(:settings) { join [_int, _int, _int, int.as(:dictionary_code)] }

      rule(:player_setup) { join [word.as(:nickname), int.as(:rating),
          rack.as(:initial_rack), int.as(:final_score) | null] }

      rule(:plays) { ((move | change | pass) >> space?).repeat }

      rule(:move) { join [str('MOVE').as(:word).as(:type), position.as(:position),
          tiles.as(:word), int.as(:score), _int, _int, rack.as(:rack), _int] }

      rule(:change) { join [str('CHANGE').as(:word).as(:type), rack.as(:rack),
          _int, _int, int.as(:swap_count) | dashes] }

      rule(:pass) { join [str('PAS').as(:word).as(:type), _int, _int, dashes |
        suggestion.as(:suggestion)] }

      rule(:suggestion) { join [position.as(:position), word.as(:word),
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
