require 'ostruct'
require_relative 'base'

module InternetScrabbleClub
  class MessageTransformers

    class History < Base
      rule(entry: subtree(:entry)) do
        OpenStruct.new(entry)
      end
    end

  end
end
