require 'anima'
require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Response

      class Seek < Messages::Base
        include Anima.new(:rating, :nickname)
      end

    end
  end
end
