# TODO: Move to rake task

require 'internet_scrabble_club/scraper/players'
require 'internet_scrabble_club/scraper/games'

Celluloid.shutdown_timeout = 2 * 60

InternetScrabbleClub::Scraper::Players.new('iscscraper', 'da39a3ee5e')
# InternetScrabbleClub::Scraper::Games.new('iscscraper', 'da39a3ee5e')

# TODO: Use supervisor group
sleep
