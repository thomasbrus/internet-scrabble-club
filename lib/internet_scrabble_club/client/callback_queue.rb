module InternetScrabbleClub
  class Client

    class CallbackQueue
      def initialize
        @queues = Hash.new { Array.new }
      end

      def enqueue(command, callback)
        @queues[command] += [callback]
      end

      def dequeue(command, default = nil)
        return @queues[command].shift if @queues[command].any?
        return yield(command) if block_given?
        return default unless default.nil?
        fail ArgumentError, "Missing callback handler for command #{command}"
      end
    end

  end
end
