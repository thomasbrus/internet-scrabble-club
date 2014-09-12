module InternetScrabbleClub
  class Client
    module Middleware
      module Request

        class EchoPing
          def initialize(stack, client)
            @stack, @client = stack, client
          end

          def call(env)
            if env.fetch(:response).values_at(:command, :sub_command) == %w(PING REPLY)
              @client.send_request('PING', 'REPLY')
            end

            @stack.call(env)
          end
        end

      end
    end
  end
end
