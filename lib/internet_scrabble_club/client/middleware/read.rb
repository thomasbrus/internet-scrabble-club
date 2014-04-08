module InternetScrabbleClub
  class Client
    module Middleware

      class Read
        def initialize(stack, socket)
          @stack, @socket = stack, socket
        end

        def call(env)
          message_length = @socket.getc.ord * 256 + @socket.getc.ord
          env[:message] = @socket.read(message_length)
          @stack.call(env)
        end
      end

    end
  end
end
