module InternetScrabbleClub
  class Client
    module Extensions

      module EchoPing
        def initialize(*args, &block)
          super; @event_emitter.on(:message) do |message|
            if [message.command, message.sub_command] == %w(PING REPLY)
              send_message('PING', 'REPLY')
            end
          end
        end
      end

    end
  end
end
