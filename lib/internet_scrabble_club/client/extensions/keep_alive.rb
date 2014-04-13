module InternetScrabbleClub
  class Client
    module Extensions

      module KeepAlive
        def initialize(*args, &block)
          every(10) { keep_alive }; super
        end

        def keep_alive
        end
      end

    end
  end
end
