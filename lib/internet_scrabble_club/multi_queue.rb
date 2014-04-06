module InternetScrabbleClub

  class MultiQueue
    def initialize
      @queues = Hash.new { [] }
    end

    def dequeue(name, default = nil)
      return @queues[name].shift if @queues[name].any?
      return yield(name) if block_given?
      return default unless default.nil?
      raise ArgumentError, "Cannot dequeue item from empty queue"
    end

    def enqueue(name, item)
      @queues[name] += [item]
    end
  end

end
