require 'parslet'
require 'celluloid/logger'
require_relative '../../message_parsers'

module InternetScrabbleClub
  class Client
    module Middleware

      class Parse
        def initialize(stack, message_parser = MessageParsers::Base.new)
          @stack, @message_parser = stack, message_parser
        end

        def call(env)
          env[:message] = @message_parser.parse(env[:message])
          @stack.call(env)
        rescue Parslet::ParseFailed
          Celluloid::Logger.warn("Failed to parse message: #{env[:message]}")
        end
      end

    end
  end
end
