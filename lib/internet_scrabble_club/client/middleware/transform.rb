require_relative '../../message_transformers'

module InternetScrabbleClub
  class Client
    module Middleware

      class Transform
        def initialize(stack, message_transformer = MessageTransformers::Base.new)
          @stack, @message_transformer = stack, message_transformer
        end

        def call(env)
          env[:message] = @message_transformer.apply(env[:message])
          @stack.call(env)
        end
      end

    end
  end
end
