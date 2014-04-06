require 'parslet'
require_relative 'message'

module InternetScrabbleClub

  class MessageTransformer < Parslet::Transform
    def apply(tree)
      command, arguments = tree.values_at(:command, :arguments)
      Message.new(command.to_sym.downcase, arguments)
    end
  end

end
