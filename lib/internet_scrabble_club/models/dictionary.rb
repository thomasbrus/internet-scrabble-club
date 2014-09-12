require 'data_mapper'
require 'dm-validations'

module InternetScrabbleClub
  module Models

    class Dictionary
      include DataMapper::Resource

      property :id, Serial
      property :code, Integer, required: true

      alias_method :to_s, :inspect
    end

  end
end
