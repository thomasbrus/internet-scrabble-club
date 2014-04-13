require 'ostruct'
require_relative '../base'

module InternetScrabbleClub
  class MessageTransformers
    module Who

      class Move < Base
        rule(nickname: simple(:nickname)) { OpenStruct.new(nickname: nickname) }
      end

    end
  end
end
