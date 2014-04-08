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
        "0 #{([command.upcase] + arguments).join(' ')}"
      end
    end

  end
end
