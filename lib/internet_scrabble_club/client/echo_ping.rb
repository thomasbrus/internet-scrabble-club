module InternetScrabbleClub
  class Client

    module EchoPing
      def initialize(*args, &block)
        super; @event_emitter.on(:message) do |message|
          if Messages::Response::Ping === message
            send_message(Messages::Request::Ping.new(message.action))
          end
        end
      end
    end

  end
end
