require_relative '../../response_transformers'

module InternetScrabbleClub
  class Client
    module Middleware
      module Response

        class Transform
          def initialize(stack, response_transformer = ResponseTransformers::Base.new)
            @stack, @response_transformer = stack, response_transformer
          end

          def call(env)
            env[:response] = @response_transformer.apply(env[:response])
            @stack.call(env)
          end
        end

      end
    end
  end
end
