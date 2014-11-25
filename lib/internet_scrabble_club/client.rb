require 'socket'

require 'celluloid/io'
require 'celluloid/autostart'

require 'events'
require 'middleware'

require_relative './client/callback_queue'
require_relative './client/middleware'

module InternetScrabbleClub

  class Client
    include Celluloid::IO

    finalizer :finalize

    attr_writer :socket, :middleware
    attr_writer :command_callback_queue, :event_emitter

    DEFAULT_HOST = '50.97.175.138'
    DEFAULT_PORT = 1330

    class InvalidCredentials < StandardError
      def initialize(message = nil)
        super(message || "Could not authenticate; the provided credentials are invalid.")
      end
    end

    def initialize(host = DEFAULT_HOST, port = DEFAULT_PORT)
      @socket = TCPSocket.new(host, port)
      @command_callback_queue = Client::CallbackQueue.new

      @event_emitter = Events::EventEmitter.new
      @event_emitter.on(:response) { |response| yield_command_callback(response) }

      Celluloid.every(50) { send_request('SEEK') }

      async.run
    end

    def run
      loop { middleware_stack.call({}) }
    end

    def authenticate(nickname, password, &callback)
      send_request('LOGIN', nickname, password, 1871, '?', &callback)
    end

    def on_response(command_regex = /.*/, &callback)
      @event_emitter.on(:response) do |response|
        callback.call(response) if response[:command] =~ command_regex
      end
    end

    def send_request(command, *arguments, &callback)
      request = ['0', command, *arguments].join(' ')
      @command_callback_queue.enqueue(command, callback)
      @socket.write("\0" << request.length << request)
    end

    def finalize
      @socket.close if @socket
    end

    private def yield_command_callback(response)
      command_callback = @command_callback_queue.dequeue(response[:command]) { proc {} }
      command_callback.call(response)
    end

    private def middleware_stack
      @middleware_stack ||= ::Middleware::Builder.new.tap { |mw|
        mw.use(Middleware::Response::Read, @socket)
        mw.use(Middleware::Response::Parse)
        mw.use(Middleware::Response::Transform)
        mw.use(Middleware::Response::Emit, @event_emitter)
        mw.use(Middleware::Request::EchoPing, self)
      }
    end
  end

end
