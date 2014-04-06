require 'parslet'
require 'descendants_tracker'

module InternetScrabbleClub

  class Message < Struct.new(:command, :arguments)
  end

end
