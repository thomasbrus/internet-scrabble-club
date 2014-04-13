require 'date'
require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub
  class MessageTransformers

    class Base < Parslet::Transform
      extend DescendantsTracker

      rule(int: simple(:int)) { Integer(int) }
      rule(word: simple(:word)) { word.to_s }
      rule(date: simple(:date)) { Date.parse(date.to_s) }

      rule(null: simple(:null)) { 0 }
      rule(tiles: simple(:tiles)) { tiles.to_s }

      rule(dashes: simple(:dashes)) { nil }

      def apply(tree, context = nil)
        descendent_transformers.reduce(super) do |tree, transformer|
          transformer.apply(tree, context)
        end
      end

      def descendent_transformers
        @descendent_transformers ||= self.class.descendants.map(&:new)
      end
    end

  end
end
