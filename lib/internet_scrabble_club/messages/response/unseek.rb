require 'anima'
require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Response

      class Unseek < Messages::Base
        include Anima.new(:nickname)
      end

    end
  end
end
