require 'anima'
require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Response

      class Login < Messages::Base
        include Anima.new(:greeting)
      end

    end
  end
end
