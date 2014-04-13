# Internet Scrabble Club

Ruby client for interacting with the [Internet Scrabble Club](http://www.isc.ro) server.

## Example

```ruby
require 'internet_scrabble_club'

client = InternetScrabbleClub::Client.new

client.authenticate('nickname', 'password') do |login|
  # Authenticated ...
  puts login.greeting # => "Welcome to the Internet Scrabble Club, <nickname>"

  # Fetch history (last ten games)
  client.send_message('HISTORY', 'thomas92') do |history|
    puts history.entries.first # => #<OpenStruct index=1, first_player="thomas92" ... >
  end

  # Inspect a recent game
  client.send_message('EXAMINE', 'HISTORY', 'thomas92', 0) do |game|
    puts game.inspect # => #<OpenStruct date=#<Date ... >, players=["thomas92", ...] ... >
  end
end
```
