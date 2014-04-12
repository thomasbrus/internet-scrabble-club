require 'celluloid'
require 'internet_scrabble_club/client'

Celluloid.logger.level = Logger::ERROR

class Scraper
  include Celluloid

  def initialize(client)
    @client = client
    @client.authenticate(ARGV[0], ARGV[1])
    @client.on_message { |message| handle_message(message) }
  end

  def handle_message(message)
    case message.command
    when /(UN)?SEEK/
      10.times { |i| @client.send_message('EXAMINE', 'HISTORY', message.nickname, i) }
    when /EXAMINE/
      puts "=== Received game === "
      puts message.inspect.slice(0, 90)
    end
  end
end

Scraper.new(InternetScrabbleClub::Client.new)

sleep
