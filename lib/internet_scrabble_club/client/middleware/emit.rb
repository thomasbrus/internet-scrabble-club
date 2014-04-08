module InternetScrabbleClub
  class Client
    module Middleware

      class Emit
        def initialize(stack, event_emitter)
          @stack, @event_emitter = stack, event_emitter
        end

        def call(env)
          @event_emitter.emit(:message, env[:message])
          @stack.call(env)
        end
      end

    end
  end
end
