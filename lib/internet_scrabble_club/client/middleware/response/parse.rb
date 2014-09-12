require 'parslet'
require 'celluloid/logger'
require_relative '../../response_parsers'

module InternetScrabbleClub
  class Client
    module Middleware
      module Response

        class Parse
          def initialize(stack, response_parser = ResponseParsers::Base.new)
            @stack, @response_parser = stack, response_parser
          end

          def call(env)
            env[:response] = @response_parser.parse(env[:response])
            @stack.call(env)
          rescue Parslet::ParseFailed
            Celluloid::Logger.warn("Failed to parse response: #{env[:response]}")
          end
        end

      end
    end
  end
end
