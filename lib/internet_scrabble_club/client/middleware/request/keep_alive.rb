require 'celluloid'
require 'celluloid/logger'

module InternetScrabbleClub
  class Client
    module Middleware
      module Request

        class KeepAlive
          def initialize(stack, client)
            @stack, @client = stack, client
            Celluloid.every(50) { keep_alive; log_keep_alive }
          end

          def keep_alive
            @client.send_request('SEEK')
          end

          private def log_keep_alive
            Celluloid::Logger.info("Sent keep alive command!")
          end

          def call(env)
            @stack.call(env)
          end
        end

      end
    end
  end
end
