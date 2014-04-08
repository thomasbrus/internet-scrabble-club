require 'anima'
require 'forwardable'

require_relative '../base'

module InternetScrabbleClub
  module Messages
    module Response

      class History < Messages::Base
        include Anima.new(:subject, :entries)
        extend Forwardable

        def_delegator :@entries, :each
      end

    end
  end
end
