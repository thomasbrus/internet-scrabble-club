module InternetScrabbleClub
  class Client
    module Middleware
      module Response

        class Read
          def initialize(stack, socket)
            @stack, @socket = stack, socket
          end

          def call(env)
            response_length = @socket.getc.ord * 256 + @socket.getc.ord
            env[:response] = @socket.read(response_length)
            @stack.call(env)
          end
        end

      end
    end
  end
end
