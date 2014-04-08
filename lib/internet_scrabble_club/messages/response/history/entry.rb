require 'anima'
require_relative '../../base'

module InternetScrabbleClub
  module Messages
    module Response
      class History

        class Entry
          include Anima.new(:index, :players, :date)
        end

      end
    end
  end
end
