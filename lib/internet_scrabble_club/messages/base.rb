module InternetScrabbleClub
  module Messages

    class Base
      def command
        fail NotImplementedError.new if self.class == Base
        self.class.name.gsub(/^.*::/, '').downcase.to_sym
      end

      def arguments
        []
      end

      def to_s
        # TODO: Move to request/base.rb
        "0 #{([command.upcase] + arguments).join(' ')}"
      end
    end

  end
end
