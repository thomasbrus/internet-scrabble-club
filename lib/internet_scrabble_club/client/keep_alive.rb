module InternetScrabbleClub
  class Client

    module KeepAlive
      def initialize(*args, &block)
        every(30) { keep_alive }; super
      end

      def keep_alive
      end
    end

  end
end
