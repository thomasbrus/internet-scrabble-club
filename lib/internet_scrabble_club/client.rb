require 'socket'

require 'celluloid/io'
require 'celluloid/autostart'

require_relative 'client/echo_ping'
require_relative 'client/keep_alive'

require_relative 'multi_queue'
require_relative 'message_parsers'
require_relative 'message_transformer'

module InternetScrabbleClub

  class Client
    include Celluloid::IO

    prepend EchoPing
    # prepend KeepAlive

    finalizer :finalize

    def initialize(host = '50.97.175.138', port = 1330)
      @callbacks = MultiQueue.new
      @message_parser = MessageParsers::Base.new
      @message_transformer = MessageTransformer.new
      @socket = TCPSocket.new(host, port)
      async.run
    end

    def authenticate(nickname, password)
      send_message(:login, nickname, password, 1871, 'HVyHL.YxgQs0EtEtYYQ2uuEm?icRMu0')
    end

    def request_history(nickname, &callback)
      @callbacks.enqueue(:history, callback)
      send_message(:history, nickname)
    end

    def examine_game(nickname, game_number, &callback)
      @callbacks.enqueue(:examine, callback)
      send_message(:examine, 'HISTORY', nickname, game_number)
    end

    def find_online_users(&callback)
      @callbacks.enqueue(:who, callback)
      send_message(:who)
    end

    def run
      loop do
        message_length = @socket.getc.ord * 256 + @socket.getc.ord
        async.handle_incoming_message(@socket.read(message_length))
      end
    end

    def handle_incoming_message(message)
      parsed_message = @message_parser.parse(message)
      constructed_message = @message_transformer.apply(parsed_message)
      callback = @callbacks.dequeue(constructed_message.command.to_sym) { proc {} }
      callback.call(constructed_message)
    rescue Parslet::ParseFailed
      Logger.debug("Failed to parse message: #{message}")
    end

    def finalize
      @socket.close if @socket
    end

    private def send_message(command, *arguments)
      message = construct_message(command, *arguments)
      @socket.write("\0" << message.length << message)
    end

    private def construct_message(command, *arguments)
      "0 #{([command.upcase] + arguments).join(' ')}"
    end
  end

end
