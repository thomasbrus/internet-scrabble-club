require 'internet_scrabble_club/scraper/players'
require 'internet_scrabble_club/scraper/games'

namespace :scrape do
  task :players do
    InternetScrabbleClub::Scraper::Players.run(ENV.fetch('NICKNAME'), ENV.fetch('PASSWORD'))
  end

  task :games do
    InternetScrabbleClub::Scraper::Games.run(ENV.fetch('NICKNAME'), ENV.fetch('PASSWORD'))
  end
end

