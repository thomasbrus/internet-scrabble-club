require 'socket'
require 'celluloid/io'
require 'celluloid/autostart'

# require 'internet_scrabble_club/client/keep_alive'
# require 'internet_scrabble_club/client/echo_ping'

module InternetScrabbleClub

  class Client
    include Celluloid::IO
    include Celluloid::Notifications

    # prepend KeepAlive
    # prepend EchoPing

    finalizer :finalize

    def initialize(host = '50.97.175.138', port = 1330)
      @socket = TCPSocket.new(host, port)
      async.run
    end

    def authenticate(nickname, password)
      send_message(:login, nickname, password, 1871, 'HVyHL.YxgQs0EtEtYYQ2uuEm?icRMu0')
    end

    def request_history(nickname)
      send_message(:history, nickname)
    end

    def examine_game(nickname, game_number)
      send_message(:examine, 'HISTORY', nickname, game_number)
    end

    def run
      loop do
        message_length = @socket.getc.ord * 256 + @socket.getc.ord
        handle_incoming_message(@socket.readpartial(message_length))
      end
    end

    def handle_incoming_message(message)
      publish(:message_received, message)
    end

    def finalize
      @socket.close if @socket
    end

    private def send_message(command, *arguments)
      message = construct_message(command, *arguments)
      @socket.write("\0" << message.length << message)
      publish(:message_sent, message)
    end

    private def construct_message(command, *arguments)
      "0 #{([command.upcase] + arguments).join(' ')}"
    end
  end

end
