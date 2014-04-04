module InternetScrabbleClub
  class Client

    module EchoPing
      def handle_message(message)
        super and (send_message(:ping, 'REPLY') if message =~ /0 PING REPLY$/)
      end
    end

  end
end
