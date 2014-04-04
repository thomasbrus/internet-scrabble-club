module InternetScrabbleClub
  class Client

    module KeepAlive
      def initialize(*args, &block)
        every(3) { keep_alive } and super
      end

      def keep_alive
        send_message(:alive, 7, current_time_with_milliseconds, memory_usage, t1, t2, 0)
      end
    end

  end
end
