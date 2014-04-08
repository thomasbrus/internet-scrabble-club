require 'anima'
require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Response

      class Ping < Messages::Base
        include Anima.new(:action)
      end

    end
  end
end
