require 'internet_scrabble_club/db'

namespace :stats do
  NEWLINE = "\n"
  FORMATTED_STATITICS_WIDTH = 40

  task :players do
    puts format_statistics('Player statistics', [
      { name: 'Total', value: InternetScrabbleClub.db[:players].count }
    ])
  end

  task :games do
    puts format_statistics('Game statistics', [
      { name: 'Total', value: InternetScrabbleClub.db[:games].count }
    ])
  end

  task :plays do
    plays_moves_count = InternetScrabbleClub.db[:plays_moves].count
    plays_passes_count = InternetScrabbleClub.db[:plays_passes].count
    plays_changes_count = InternetScrabbleClub.db[:plays_changes].count

    puts format_statistics('Play (move, change, pass) statistics', [
      { name: 'Moves', value: plays_moves_count },
      { name: 'Passes', value: plays_passes_count },
      { name: 'Changes', value: plays_changes_count },
      { name: 'Total', value: plays_moves_count + plays_passes_count + plays_changes_count }
    ])
  end

  def format_statistics(title, stats)
    String.new.tap do |str|
      str << title << NEWLINE
      str << ('=' * FORMATTED_STATITICS_WIDTH) << NEWLINE
      str << format_statistics_body(stats)
      str << ('-' * FORMATTED_STATITICS_WIDTH) << NEWLINE
      str << NEWLINE
    end
  end

  private def format_statistics_body(stats)
    stats.map { |stat|
      stat[:name].to_s.ljust(FORMATTED_STATITICS_WIDTH / 2) <<
      stat[:value].to_s.rjust(FORMATTED_STATITICS_WIDTH / 2)
    }.join(NEWLINE) << NEWLINE
  end
end

task :stats => %w(stats:players stats:games stats:plays)

