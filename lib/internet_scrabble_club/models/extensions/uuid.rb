require 'securerandom'

module InternetScrabbleClub
  module Models
    module Extensions

      module UUID
        def initialize(attributes)
          super({ id: SecureRandom.uuid }.merge(attributes))
        end
      end

    end
  end
end

