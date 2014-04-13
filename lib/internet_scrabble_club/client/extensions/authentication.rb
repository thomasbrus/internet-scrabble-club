module InternetScrabbleClub
  class Client
    module Extensions

      module Authentication
        def initialize(*args, &block)
          super; @event_emitter.on(:message) do |message|
            if message.command == 'CLOSE' && message.reason =~ /^Invalid password/
              fail InvalidCredentials
            end
          end
        end

        def authenticate(nickname, password, &callback)
          send_message('LOGIN', nickname, password, 1871, '?', &callback)
        end
      end

    end
  end
end
