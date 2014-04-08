require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub
  class MessageTransformers

    class Base < Parslet::Transform
      extend DescendantsTracker

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
