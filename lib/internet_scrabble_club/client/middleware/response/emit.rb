module InternetScrabbleClub
  class Client
    module Middleware
      module Response

        class Emit
          def initialize(stack, event_emitter)
            @stack, @event_emitter = stack, event_emitter
          end

          def call(env)
            @event_emitter.emit(:response, env[:response])
            @stack.call(env)
          end
        end

      end
    end
  end
end
