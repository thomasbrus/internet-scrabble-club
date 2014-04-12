module InternetScrabbleClub
  class Client

    module EchoPing
      def initialize(*args, &block)
        super; @event_emitter.on(:message) do |message|
          if message.command == 'PING' && message.action == 'REPLY'
            send_message('PING', 'REPLY')
          end
        end
      end
    end

  end
end
