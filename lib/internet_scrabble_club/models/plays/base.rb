require 'data_mapper'
require 'dm-validations'

module InternetScrabbleClub
  module Models
    module Plays

      class Base
        include DataMapper::Resource

        property :id, Serial
        property :index, Integer, required: true
        property :type, Discriminator, required: true

        belongs_to :game, 'InternetScrabbleClub::Models::Game'

        alias_method :to_s, :inspect
      end

    end
  end
end

