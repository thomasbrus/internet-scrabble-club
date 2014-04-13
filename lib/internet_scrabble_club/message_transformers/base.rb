require 'date'
require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub
  class MessageTransformers

    class Base < Parslet::Transform
      extend DescendantsTracker

      rule(command: simple(:cmd), arguments: subtree(:args)) do
        OpenStruct.new(args.to_h.merge(command: cmd.to_s))
      end

      rule(command: simple(:cmd), sub_command: simple(:sub_cmd)) do
        OpenStruct.new(command: cmd.to_s, sub_command: sub_cmd.to_s)
      end

      rule(command: simple(:cmd), sub_command: simple(:sub_cmd), arguments: subtree(:args)) do
        OpenStruct.new(args.to_h.merge(command: cmd.to_s, sub_command: sub_cmd.to_s))
      end

      rule(int: simple(:int)) { Integer(int) }

      rule(word: simple(:word)) { word.to_s }
      rule(sentence: simple(:sentence)) { sentence.to_s }
      rule(text: simple(:text)) { text.to_s }

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
