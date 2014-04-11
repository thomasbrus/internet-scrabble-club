require 'socket'

require 'celluloid/io'
require 'celluloid/autostart'

require 'events'
require 'middleware'

require_relative 'multi_queue'

require_relative 'client/echo_ping'
require_relative 'client/keep_alive'

require_relative 'messages'
require_relative 'client/middleware'

module InternetScrabbleClub

  class Client
    include Celluloid::IO

    prepend EchoPing
    prepend KeepAlive

    finalizer :finalize

    attr_writer :socket, :middleware
    attr_writer :command_callback_queue, :event_emitter

    def initialize(host = '50.97.175.138', port = 1330)
      @socket = TCPSocket.new(host, port)
      @command_callback_queue = MultiQueue.new
      @event_emitter = Events::EventEmitter.new
      @event_emitter.on(:message) { |message| yield_command_callback(message) }

      async.run
    end

    def run
      loop { middleware.call({}) }
    end

    def on_message(&callback)
      @event_emitter.on(:message, &callback)
    end

    def authenticate(nickname, password, &callback)
      send_message(Messages::Request::Login.new(nickname, password), &callback)
    end

    def send_message(message, &callback)
      @command_callback_queue.enqueue(message.command, callback)
      @socket.write("\0" << message.to_s.length << message.to_s)
    end

    def finalize
      @socket.close if @socket
    end

    private def yield_command_callback(message)
      command_callback = @command_callback_queue.dequeue(message.command) { proc {} }
      command_callback.call(message)
    end

    private def middleware
      @middleware ||= ::Middleware::Builder.new.tap { |mw|
        mw.use(Middleware::Read, @socket)
        mw.use(Middleware::Parse)
        mw.use(Middleware::Transform)
        mw.use(Middleware::Emit, @event_emitter)
      }
    end
  end

end
